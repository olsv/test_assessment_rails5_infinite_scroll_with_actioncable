require 'rails_helper'

RSpec.feature 'UserManagement', type: :feature do
  let!(:per_page) { User.default_per_page }


  let(:valid_attributes) { attributes_for(:user) }

  scenario 'create user' do
    visit new_user_path

    fill_in 'Email', with: 'invalid value'

    click_on 'Create User'

    expect(page).to have_text "First name can't be blank"
    expect(page).to have_text "Last name can't be blank"
    expect(page).to have_text "Email is invalid"

    fill_in 'First name', with: valid_attributes[:first_name]
    fill_in 'Last name', with: valid_attributes[:last_name]
    fill_in 'Email', with: valid_attributes[:email]

    click_on 'Create User'

    expect(page).to have_text 'User was successfully created'
  end

  scenario 'list users' do
    User.delete_all

    user = FactoryBot.create(:user)

    visit users_path

    expect(page).to_not have_css '.pagination'

    other_users = FactoryBot.create_list(:user, per_page * 3 - 1)
    all_users = other_users + [user]

    visit users_path

    # Ordering

    columns = {first_name: 'First Name', last_name: 'Last Name', email: 'Email'}

    columns.each_pair.each_with_index do |(field, column_name), idx|
      click_on column_name

      within('.users') do
        nodes = page.all("tr > td:nth-child(#{ idx + 1 })").map(&:text)
        expected = all_users.sort_by(&field).map(&field).first(per_page)

        expect(nodes).to eql expected
      end

      click_on column_name

      within('.users') do
        nodes = page.all("tr > td:nth-child(#{ idx + 1 })").map(&:text)
        expected = all_users.sort_by(&field).map(&field).reverse.first(per_page)

        expect(nodes).to eql expected
      end
    end

    # Emails now in reversed state
    all_emails = all_users.sort_by(&:email).map(&:email).reverse

    # Pagination
    within('.pagination') do
      click_on '2'
    end

    within('.users') do
      nodes = page.all('tr > td:nth-child(3)').map(&:text)
      expected = all_emails[per_page..per_page * 2 - 1]

      expect(nodes).to eql expected
    end

    within('.pagination') do
      click_on 'Next'
    end

    within('.users') do
      nodes = page.all('tr > td:nth-child(3)').map(&:text)
      expected = all_emails[per_page * 2..per_page * 3 - 1]

      expect(nodes).to eql expected
    end
  end
end
