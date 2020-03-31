require 'rails_helper'

RSpec.feature 'Recipes Show page viewable by user role', type: :feature do
  let!(:author) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:author_recipe) { create(:recipe, user: author) }
  let!(:shopping_list) { create(:shopping_list, user: author) }
  let!(:author_meal_plan) { create(:meal_plan, user: author, start_date: Time.zone.now + 10) }
  let!(:author_meal_plan_recipe) { create(:meal_plan_recipe, meal_plan: author_meal_plan) }
  let!(:other_user_meal_plan) { create(:meal_plan, user: other_user, start_date: Time.zone.now + 10) }
  let!(:other_user_meal_plan_recipe) { create(:meal_plan_recipe, meal_plan: other_user_meal_plan) }

  describe 'recipes viewable without authentication and by non-authors' do
    before do
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: other_user.email
        fill_in 'Password', with: other_user.password
      end
      click_button 'Log in'
    end

    context 'show page' do
      it 'does not show the meal plans' do
        visit "/recipes/#{author_recipe.id}"

        expect(page).to_not have_content 'Related Meal Plans'
        expect(page).to_not have_content 'Add to Upcoming Plans'
      end

      it 'does not show the edit button' do
        visit "/recipes/#{author_recipe.id}"
        expect(page).to_not have_content 'Edit'
      end

      it 'does not show the "add to shopping list" feature' do
        visit "/recipes/#{author_recipe.id}"
        expect(page).to_not have_content 'Add Ingredients to List'
      end

      it 'does not show the "copy for user" feature' do
        visit "/recipes/#{author_recipe.id}"
        expect(page).to_not have_content 'Copy Recipe for User'
      end
    end
  end

  describe 'recipes viewable by author' do
    before do
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: author.email
        fill_in 'Password', with: author.password
      end
      click_button 'Log in'
    end

    context 'show page' do
      it 'displays the meal plans' do
        create(:meal_plan, user: author)
        visit "/recipes/#{author_recipe.id}"

        expect(page).to have_content 'Related Meal Plans'
        expect(page).to have_content 'Add to Upcoming Plans'
      end

      it 'displays the edit button' do
        visit "/recipes/#{author_recipe.id}"
        expect(page).to have_content 'Edit'
      end

      it 'displays the "add to shopping list" feature' do
        visit "/recipes/#{author_recipe.id}"
        expect(page).to have_content 'Add Ingredients to List'
      end

      it 'displays the "copy for user" feature' do
        visit "/recipes/#{author_recipe.id}"
        expect(page).to_not have_content 'Copy Recipe for User'
      end
    end
  end
end
