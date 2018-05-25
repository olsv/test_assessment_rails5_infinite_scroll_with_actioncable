require 'rails_helper'

RSpec.describe "users/index", type: :view do
  let(:users) { build_stubbed_list(:user, 2) }

  before(:each) do
    assign :users, Kaminari.paginate_array(users).page(nil)
    assign :sort_params, { field: 'last_name', direction: 'desc' }
  end

  it "renders a list of users" do
    render
    assert_select "th > a.current.desc", text: 'Last Name'

    %i(email first_name last_name).each do |field|
      users.each do |user|
        assert_select "tr>td", text: user.public_send(field)
      end
    end
  end
end
