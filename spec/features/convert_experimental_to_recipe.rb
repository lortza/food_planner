require "rails_helper"

describe "the signin process", type: :feature do
  before :each do
    User.create(email: 'user@example.com', password: 'password')
  end

  it "signs me in" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in'
  end
end

# xfeature 'User converts an experimental recipe to a recipe' do
#   let(:experimental_recipe) { create(:experimental_recipe) }
#   let(:user) { create(:user) }
#
#   before do
#     sign_in(user)
#     visit(experimental_recipes_path)
#   end
#
#   it 'populates a new recipe with existing data' do
#     click_link('convert to recipe')
#
#     expect(page).to have_content("Create a Recipe")
#     expect(page).to have_content(experimental_recipe.title)
#     expect(page).to have_content(experimental_recipe.url)
#   end
#
#   it 'Experimenal recipe is deleted after new recipe is saved' do
#     click_link('convert to recipe')
#
#     # fill out servings
#     # fill out prep time
#     # fill out 1 ingredient
#     # fill out instructions
#     # click submit
#
#     experimental_recipe.reload
#     expect(experimental_recipe).to eq(nil)
#   end
# end
