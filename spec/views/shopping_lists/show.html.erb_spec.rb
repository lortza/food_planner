# frozen_string_literal: true

# require 'rails_helper'

RSpec.describe "shopping_lists/show", type: :view do
  before(:each) do
    @user = create(:user)
    @shopping_list = create(:shopping_list, user_id: @user.id)
    allow(view).to receive(:current_user).and_return(@user)
    render
  end

  it "displays basic shopping_list info" do
    expect(rendered).to match(/Schedule an upcoming delivery/)
    expect(rendered).to match(/Shopping List Name 1/)
  end

  # TODO: test for conditionally-rendered delivery info
  # https://gist.github.com/xirukitepe/4030061
  # context 'when a delivery is present' do
  #   before do
  #     create(:scheduled_delivery, shopping_list: @shopping_list)
  #     create(:shopping_list_item, shopping_list_id: @shopping_list.id)
  #   end

  #   it 'displays the delivery information' do
  #     expect(rendered).to match(/date goes here/)
  #   end

  #   it 'displays the add_to_shopping_cart icon' do
  #     expect(rendered).to match(/add_shopping_cart/)
  #   end
  # end

  # context 'when a delivery is not present' do
  #   before do
  #     create(:shopping_list_item, shopping_list_id: @shopping_list.id)
  #   end

  #   it 'does not display the add_to_shopping_cart icon' do
  #     expect(rendered).to_not match(/add_shopping_cart/)
  #   end
  # end
end
