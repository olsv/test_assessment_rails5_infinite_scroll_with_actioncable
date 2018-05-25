require 'rails_helper'

RSpec.describe "users/show", type: :view do
  let(:user) { build_stubbed(:user) }
  before(:each) do
    @user = assign(:user, user)
  end

  it "renders attributes in <p>" do
    render

    %i(first_name last_name email).each do |field|
      expect(rendered).to match(user.public_send(field))
    end
  end
end
