# frozen_string_literal: true

RSpec.describe Recipe, type: :model do
  let(:recipe) { build(:recipe) }

  context "associations" do
    it { should belong_to(:user) }
    it { should have_many(:ingredients) }
    it { should have_many(:meal_plan_recipes) }
    it { should have_many(:meal_plans).through(:meal_plan_recipes) }

    it { should accept_nested_attributes_for(:ingredients).allow_destroy(true) }
  end

  describe "a valid recipe" do
    context "when has valid params" do
      it "is valid" do
        expect(recipe).to be_valid
      end
    end

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:servings) }
    it { should validate_presence_of(:instructions) }
    it { should validate_presence_of(:prep_day_instructions) }
    it { should validate_presence_of(:prep_time) }
    it { should validate_presence_of(:cook_time) }
    it { should validate_presence_of(:reheat_time) }

    it "ensures that 1 of [prep_time | cook_time | reheat_time] has a value" do
      recipe = build(:recipe, prep_time: 0, cook_time: 0, reheat_time: 0)
      expect(recipe).to_not be_valid

      recipe = build(:recipe, prep_time: 1, cook_time: 0, reheat_time: 0)
      expect(recipe).to be_valid

      recipe = build(:recipe, prep_time: 0, cook_time: 1, reheat_time: 0)
      expect(recipe).to be_valid
    end

    describe "title uniqueness" do
      let(:user_1) { create(:user) }
      let(:user_2) { create(:user) }

      it 'considers "FOO" and "foo" to be the same title' do
        create(:recipe, user_id: user_1.id, title: "FOO")
        recipe_2 = build(:recipe, user_id: user_1.id, title: "foo")
        expect(recipe_2.valid?).to be(false)
      end

      it "does not permit the same user to have multiple recipes with the same title" do
        create(:recipe, user_id: user_1.id, title: "Foo")
        recipe_2 = build(:recipe, user_id: user_1.id, title: "Foo")
        expect(recipe_2.valid?).to be(false)
      end

      it "permits multiple users to have the same recipe title" do
        create(:recipe, user_id: user_1.id, title: "Foo")
        recipe_2 = build(:recipe, user_id: user_2.id, title: "Foo")
        expect(recipe_2.valid?).to be(true)
      end
    end

    describe "title normalization" do
      it "strips leading/trailing whitespace and squishes internal blankspace before validation" do
        recipe = build(:recipe, title: "  Example    Recipe  ")
        expect(recipe.valid?).to be(true)
        expect(recipe.title).to eq("Example Recipe")
      end
    end

    describe "before validations" do
      describe "guarantee_instructions_values" do
        let(:instructions_value) { "instructions value" }
        let(:prep_day_instructions_value) { "prep_day_instructions value" }

        context "when a new recipe has neither instructions nor prep_day_instructions" do
          let(:recipe) { build(:recipe, instructions: "", prep_day_instructions: "") }

          it "fails validation" do
            expect(recipe.valid?).to be(false)
          end

          it "raises an error on save!" do
            expect { recipe.save! }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end

        context "when a new recipe has both instructions and prep_day_instructions" do
          let(:recipe) { build(:recipe, instructions: instructions_value, prep_day_instructions: prep_day_instructions_value) }

          it "does not modify the value for instructions" do
            recipe.save
            recipe.reload
            expect(recipe.instructions).to eq(instructions_value)
          end

          it "does not modify the value for prep_day_instructions" do
            recipe.save
            recipe.reload
            expect(recipe.prep_day_instructions).to eq(prep_day_instructions_value)
          end
        end

        context "when a new recipe has instructions but not prep_day_instructions" do
          let(:recipe) { build(:recipe, instructions: instructions_value, prep_day_instructions: "") }

          it "fills the prep_day_instructions field with the instructions data" do
            recipe.save
            recipe.reload
            expect(recipe.prep_day_instructions).to eq(instructions_value)
          end

          it "does not modify the value for instructions" do
            recipe.save
            recipe.reload
            expect(recipe.instructions).to eq(instructions_value)
          end
        end

        context "when a new recipe has prep_day_instructions but not instructions" do
          let(:recipe) { build(:recipe, instructions: "", prep_day_instructions: prep_day_instructions_value) }

          it "fills the instructions field with the prep_day_instructions data" do
            recipe.save
            recipe.reload
            expect(recipe.instructions).to eq(prep_day_instructions_value)
          end

          it "does not modify the value for prep_day_instructions" do
            recipe.save
            recipe.reload
            expect(recipe.prep_day_instructions).to eq(prep_day_instructions_value)
          end
        end
      end

      describe "provide_default_source" do
        context "when it does not have a source" do
          let(:recipe_missing_source) { create(:recipe, source_name: "", source_url: "") }

          it "is provided a source name" do
            expect(recipe_missing_source.source_name).to eq(Recipe::DEFAULT_SOURCE[:source_name])
          end

          it "is provided a source url" do
            expect(recipe_missing_source.source_url).to eq(Recipe::DEFAULT_SOURCE[:source_url])
          end
        end
      end
    end
  end

  describe "self.by_last_prepared" do
    it "puts recipes that have not been made in a while on top" do
      recent_recipe = create(:recipe)
      create(:meal_plan, recipes: [recent_recipe], prepared_on: "2020-06-15")
      old_recipe = create(:recipe)
      create(:meal_plan, recipes: [old_recipe], prepared_on: "2018-06-15")
      ordered_recipes = Recipe.includes(:meal_plans, :meal_plan_recipes).by_last_prepared

      expect(ordered_recipes.first).to eq(old_recipe)
      expect(ordered_recipes.last).to eq(recent_recipe)
    end
  end

  describe "#last_prepared" do
    let(:meal_plan_today) { create(:meal_plan, prepared_on: Time.zone.today) }
    let(:meal_plan_yesterday) { create(:meal_plan, prepared_on: Time.zone.yesterday) }
    let(:recipe) { create(:recipe) }

    it "returns the prepared_on of the most recent meal plan this recipe was included in" do
      meal_plan_today.recipes << recipe
      meal_plan_yesterday.recipes << recipe

      expect(recipe.last_prepared).to eq(meal_plan_today.prepared_on)
    end
  end

  describe "#total_time" do
    it "adds the prep and cook times together" do
      recipe.prep_time = 1
      recipe.cook_time = 1
      expect(recipe.total_time).to eq(2)
    end
  end

  describe "extra_work_required?" do
    it "returns true if there is an extra_work_note" do
      recipe = build(:recipe, extra_work_note: "lorem")
      expect(recipe.extra_work_required?).to be(true)
    end

    it "returns false if the value is nil" do
      recipe = build(:recipe, extra_work_note: nil)
      expect(recipe.extra_work_required?).to be(false)
    end

    it "returns false if the value is a blank space" do
      recipe = build(:recipe, extra_work_note: " ")
      expect(recipe.extra_work_required?).to be(false)
    end
  end

  describe "dupe_for_user" do
    let!(:original_recipe_holder) { create(:user) }
    let!(:original_recipe) { create(:recipe, :with_2_ingredients, user_id: original_recipe_holder.id) }
    let!(:recipe_recipient) { create(:user) }

    it "copies a recipe from one user to another" do
      original_recipe.dupe_for_user(recipe_recipient)
      duped_recipe = recipe_recipient.recipes.first

      expect(duped_recipe.title).to eq(original_recipe.title)
      expect(recipe_recipient.recipes.first.title).to eq(original_recipe.title)
    end

    it "brings the recipe ingredients along with the dupe" do
      original_recipe.dupe_for_user(recipe_recipient)
      duped_recipe = recipe_recipient.recipes.first

      expect(duped_recipe.ingredients.first.name).to eq(original_recipe.ingredients.first.name)
    end

    it "leaves the original recipe in the original users account" do
      original_recipe.dupe_for_user(recipe_recipient)
      expect(original_recipe_holder.recipes.first.title).to eq(original_recipe.title)
    end

    it "leaves the original recipe ingredients on the original recipe" do
      ingredient_before = original_recipe_holder.recipes.first.ingredients.first
      original_recipe.dupe_for_user(recipe_recipient)
      ingredient_after = original_recipe_holder.recipes.first.ingredients.first

      expect(ingredient_before.name).to eq(ingredient_after.name)
    end

    it "doesn't dupe anything other than recipe ingredients" do
      meal_plan = create(:meal_plan, user_id: original_recipe_holder.id)
      meal_plan.recipes << original_recipe

      expect(original_recipe_holder.meal_plans.first.recipes.first.title).to eq(original_recipe.title)
      expect(recipe_recipient.meal_plans).to eq([])
    end
  end
end
