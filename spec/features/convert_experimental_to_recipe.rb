require 'rails_helper'

describe 'User converts an experimental recipe to a recipe', type: :feature do
  let(:user) { create(:user) }
  let(:experimental_recipe) { create(:experimental_recipe, user: user) }

  before do
    experimental_recipe

    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_button 'Log in'

    visit(experimental_recipes_path)
    click_link('convert to recipe')
  end

  it 'populates a new recipe with existing data' do
    expect(page).to have_content('Create a Recipe')
    expect(page).to have_field('Title', with: experimental_recipe.title)
    expect(page).to have_field('Source url', with: experimental_recipe.source_url)
  end

  it 'Experimenal recipe is deleted after new recipe is saved' do
    fill_in 'Servings', with: '4'
    fill_in 'recipe_prep_time', with: '20'
    fill_in 'recipe_cook_time', with: '20'
    fill_in 'recipe_image_url', with: 'recipe_placeholder.jpg'
    find('#recipe_ingredients_attributes_0_quantity').set('1')
    find('#recipe_ingredients_attributes_0_quantity').set('1')
    select 'cup', from: 'recipe_ingredients_attributes_0_measurement_unit'
    find('#recipe_ingredients_attributes_0_name').set('water')
    find('#recipe_instructions').set('Lorem ipsum')

    click_button('Create Recipe')
    expect(page).to have_content(experimental_recipe.title)

    visit(experimental_recipes_path)
    expect(page).to_not have_content(experimental_recipe.title)

    expect(user.recipes.count).to eq(1)
    expect(user.experimental_recipes.count).to eq(0)
  end
end
