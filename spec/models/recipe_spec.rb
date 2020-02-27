# frozen_string_literal: true

RSpec.describe Recipe, type: :model do
  let(:recipe) { build(:recipe) }

  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:ingredients) }
    it { should have_many(:meal_plan_recipes) }
    it { should have_many(:meal_plans).through(:meal_plan_recipes) }

    it { should accept_nested_attributes_for(:ingredients).allow_destroy(true) }
  end

  describe 'a valid recipe' do
    context 'when has valid params' do
      it 'is valid' do
        expect(recipe).to be_valid
      end
    end

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:servings) }
    it { should validate_presence_of(:instructions) }
    it { should validate_presence_of(:prep_time) }
    it { should validate_presence_of(:cook_time) }
    it { should validate_presence_of(:reheat_time) }

    it 'ensures that 1 of [prep_time | cook_time | reheat_time] has a value' do
      recipe = build(:recipe, prep_time: 0, cook_time: 0, reheat_time: 0)
      expect(recipe).to_not be_valid

      recipe = build(:recipe, prep_time: 1, cook_time: 0, reheat_time: 0)
      expect(recipe).to be_valid

      recipe = build(:recipe, prep_time: 0, cook_time: 1, reheat_time: 0)
      expect(recipe).to be_valid
    end

    context 'when it does not have a source' do
      let(:recipe_missing_source) { create(:recipe, source_name: '', source_url: '') }

      it 'is provided a source name' do
        expect(recipe_missing_source.source_name).to eq(Recipe::DEFAULT_SOURCE[:source_name])
      end

      it 'is provided a source url' do
        expect(recipe_missing_source.source_url).to eq(Recipe::DEFAULT_SOURCE[:source_url])
      end
    end
  end

  describe '#last_prepared' do
    let(:meal_plan_today) { create(:meal_plan, start_date: Time.zone.today) }
    let(:meal_plan_yesterday) { create(:meal_plan, start_date: Time.zone.yesterday) }
    let(:recipe) { create(:recipe) }

    it 'returns the start_date of the most recent meal plan this recipe was included in' do
      meal_plan_today.recipes << recipe
      meal_plan_yesterday.recipes << recipe

      expect(recipe.last_prepared).to eq(meal_plan_today.start_date)
    end
  end

  describe '#total_time' do
    it 'adds the prep and cook times together' do
      recipe.prep_time = 1
      recipe.cook_time = 1
      expect(recipe.total_time).to eq(2)
    end
  end

  describe 'extra_work_required?' do
    it 'returns true if there is an extra_work_note' do
      recipe = build(:recipe, extra_work_note: 'lorem')
      expect(recipe.extra_work_required?).to be(true)
    end

    it 'returns false if the value is nil' do
      recipe = build(:recipe, extra_work_note: nil)
      expect(recipe.extra_work_required?).to be(false)
    end

    it 'returns false if the value is a blank space' do
      recipe = build(:recipe, extra_work_note: ' ')
      expect(recipe.extra_work_required?).to be(false)
    end
  end

  describe 'dupe_for_user' do
    let!(:original_recipe_holder) { create(:user) }
    let!(:original_recipe) { create(:recipe, :with_2_ingredients, user_id: original_recipe_holder.id) }
    let!(:recipe_recipient) { create(:user) }

    it 'copies a recipe from one user to another' do
      original_recipe.dupe_for_user(recipe_recipient)
      duped_recipe = recipe_recipient.recipes.first

      expect(duped_recipe.title).to eq(original_recipe.title)
      expect(recipe_recipient.recipes.first.title).to eq(original_recipe.title)
    end

    it 'brings the recipe ingredients along with the dupe' do
      original_recipe.dupe_for_user(recipe_recipient)
      duped_recipe = recipe_recipient.recipes.first

      expect(duped_recipe.ingredients.first.name).to eq(original_recipe.ingredients.first.name)
    end

    it 'leaves the original recipe in the original users account' do
      original_recipe.dupe_for_user(recipe_recipient)
      expect(original_recipe_holder.recipes.first.title).to eq(original_recipe.title)
    end

    it "doesn't dupe anything other than recipe ingredients" do
      meal_plan = create(:meal_plan, user_id: original_recipe_holder.id)
      meal_plan.recipes << original_recipe

      expect(original_recipe_holder.meal_plans.first.recipes.first.title).to eq(original_recipe.title)
      expect(recipe_recipient.meal_plans).to eq([])
    end
  end
end
