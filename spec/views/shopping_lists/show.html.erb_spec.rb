# frozen_string_literal: true

# require 'rails_helper'

RSpec.describe 'shopping_lists/show', type: :view do
  before(:each) do
    @user = create(:user)
    @shopping_list = create(:shopping_list, user_id: @user.id)
  end

  it 'displays basic shopping_list info' do
    allow(view).to receive(:current_user).and_return(@user)
    render
    expect(rendered).to match(/Clear List/)
    expect(rendered).to match(/Add Delivery/)
    expect(rendered).to match(/Shopping List Name 1/)
  end
end
