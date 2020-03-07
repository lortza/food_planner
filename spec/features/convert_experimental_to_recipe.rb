require "rails_helper"

xfeature 'User converts an experimental recipe to a recipe' do
  let(:experimental_recipe) { create(:experimental_recipe) }
  let(:user) { create(:user) }

  before do
    sign_in(user)
    visit(experimental_recipes_path)
  end

  it 'populates a new recipe with existing data' do
    click_link('convert to recipe')

    expect(page).to have_content("Create a Recipe")
    expect(page).to have_content(experimental_recipe.title)
    expect(page).to have_content(experimental_recipe.url)
  end

  it 'Experimenal recipe is deleted after new recipe is saved' do
    click_link('convert to recipe')

    # fill out servings
    # fill out prep time
    # fill out 1 ingredient
    # fill out instructions
    # click submit

    experimental_recipe.reload
    expect(experimental_recipe).to eq(nil)
  end
end

#
# feature "User creates a new Cut" do
#   context "as an admin user" do
#     let(:admin_user) { create(:admin, first_name: "Admin", last_name: "User") }
#     let(:lot) { create(:lot) }
#     let(:died_on) { Date.new(2018, 9, 20) }
#     let(:head_count) { 12000 }
#
#     scenario "successfully" do
#
#       sign_in(admin_user)
#       visit lot_path(lot)
#
#       click_on "New Cut"
#
#       fill_in "cut[cut_on]",      with: died_on
#       fill_in "cut[head_count]",   with: head_count
#
#       click_on "Submit"
#
#       expect(page).to have_content("was successfully created.")
#     end
#   end
#
#   context "as an operations manager user" do
#     let(:operations_user) { create(:operations_manager, first_name: "Operations", last_name: "Manager") }
#     let(:lot) { create(:lot) }
#     let(:cut_on) { Date.new(2018, 9, 20) }
#     let(:head_count) { 12000 }
#
#     scenario "successfully" do
#       sign_in(operations_user)
#       visit lot_path(lot)
#
#       click_on "New Cut"
#
#       fill_in "cut[cut_on]",      with: cut_on
#       fill_in "cut[head_count]",   with: head_count
#
#       click_on "Submit"
#
#       expect(page).to have_content("was successfully created.")
#     end
#   end
#
#   context "as a field agent" do
#     let(:buyer_agent) { create(:buyer_agent, first_name: "Sally", last_name: "Field") }
#     let(:lot) { create(:lot) }
#
#     scenario "cannot access the new cut form" do
#       sign_in(buyer_agent)
#
#       visit lot_path(lot)
#
#       click_on "New Cut"
#
#       expect(page).to have_content("not authorized to perform this action")
#     end
#   end
# end
