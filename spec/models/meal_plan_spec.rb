# frozen_string_literal: true

RSpec.describe MealPlan, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should have_many(:meal_plan_recipes) }
    it { should have_many(:recipes).through(:meal_plan_recipes) }
    it { should have_many(:ingredients).through(:recipes) }
  end

  describe "a valid meal_plan" do
    let(:meal_plan) { build(:meal_plan) }

    context "when has valid params" do
      it "is valid" do
        expect(meal_plan).to be_valid
      end
    end

    it { should validate_presence_of(:prepared_on) }
    it { should validate_presence_of(:people_served) }

    it "has a unique prepared_on scoped to user" do
      create(:meal_plan)
      should validate_uniqueness_of(:prepared_on).scoped_to(:user_id)
    end
  end

  describe "self.most_recent_first" do
    it "displays all meal plans in descending prepared_on order" do
      meal_plan1 = create(:meal_plan, prepared_on: Time.zone.yesterday)
      meal_plan2 = create(:meal_plan, prepared_on: Time.zone.today)

      expect(MealPlan.most_recent_first.first).to eq(meal_plan2)
      expect(MealPlan.most_recent_first.last).to eq(meal_plan1)
    end
  end

  describe "self.suggested_date" do
    let(:user) { create(:user) }
    let(:today_saturday) { "2020-08-15".to_date }
    let(:upcoming_sunday) { today_saturday + 1.day }
    let(:random_past_wednesday) { "2020-08-05".to_date }

    it "returns upcoming sunday if there are no meal plans for the user" do
      allow(Date).to receive(:today).and_return(today_saturday)

      date = MealPlan.suggested_date(user)
      expect(date).to eq(upcoming_sunday)
    end

    it "returns upcoming sunday if the latest meal plan is more than a week old" do
      latest_plan_date = today_saturday - 9.days
      create(:meal_plan, user: user, prepared_on: latest_plan_date)

      travel_to today_saturday do
        date = MealPlan.suggested_date(user)
        expect(date).to eq(upcoming_sunday)
      end
    end

    it "returns date_after_last_meal_plan if the latest meal_plan is only a week old" do
      latest_plan_date = today_saturday - 6.days

      create(:meal_plan, user: user, prepared_on: latest_plan_date)

      travel_to today_saturday do
        expect(MealPlan).to receive(:date_after_last_meal_plan)
        MealPlan.suggested_date(user)
      end
    end
  end

  describe "self.date_after_last_meal_plan" do
    let(:user) { create(:user) }
    let(:random_past_wednesday) { "2020-08-05".to_date }

    it "chooses a date later than the latest meal plan" do
      plan1 = create(:meal_plan, user: user, prepared_on: random_past_wednesday)
      new_date = MealPlan.date_after_last_meal_plan(random_past_wednesday)

      expect(new_date).to be > plan1.prepared_on
    end

    it "chooses a sunday" do
      create(:meal_plan, user: user, prepared_on: random_past_wednesday)
      new_date = MealPlan.date_after_last_meal_plan(random_past_wednesday)
      sunday_number = 0

      expect(new_date.wday).to eq(sunday_number)
    end
  end

  describe "self.future" do
    it "returns a list of meal plans starting today or in the future" do
      user = build(:user)
      past_plan = create(:meal_plan, user: user, prepared_on: Time.zone.today - 2)
      todays_plan = create(:meal_plan, user: user, prepared_on: Time.zone.today)
      upcoming_plan = create(:meal_plan, user: user, prepared_on: Time.zone.today + 2)
      future_plan = create(:meal_plan, user: user, prepared_on: Time.zone.today + 4)

      future_plans = user.meal_plans.future
      expect(future_plans).to_not include(past_plan)
      expect(future_plans).to include(todays_plan)
      expect(future_plans).to include(upcoming_plan)
      expect(future_plans).to include(future_plan)
    end
  end

  describe "upcoming" do
    it "returns a single meal plan" do
      user = build(:user)
      past_plan = create(:meal_plan, user: user, prepared_on: Time.zone.today - 2)
      upcoming_plan = create(:meal_plan, user: user, prepared_on: Time.zone.today + 2)
      future_plan = create(:meal_plan, user: user, prepared_on: Time.zone.today + 4)

      user_upcoming_plan = user.meal_plans.upcoming
      expect(user_upcoming_plan).to_not eq(past_plan)
      expect(user_upcoming_plan).to eq(upcoming_plan)
      expect(user_upcoming_plan).to_not eq(future_plan)
    end

    it "returns the meal plan that is next closest in the future to today" do
      user = build(:user)
      upcoming_plan = create(:meal_plan, user: user, prepared_on: Time.zone.today + 2)
      future_plan = create(:meal_plan, user: user, prepared_on: Time.zone.today + 4)

      user_upcoming_plan = user.meal_plans.upcoming
      expect(user_upcoming_plan).to eq(upcoming_plan)
      expect(user_upcoming_plan).to_not eq(future_plan)
    end
  end

  describe "#total_servings" do
    let(:meal_plan) { build(:meal_plan) }
    let(:standard_servings) { 2 }
    let(:qty_recipes) { 2 }

    it "returns a total of servings for all recipes in meal plan" do
      qty_recipes.times do
        meal_plan.recipes << create(:recipe, servings: standard_servings)
        meal_plan.save
      end
      expect(meal_plan.total_servings).to eq(standard_servings * qty_recipes)
      expect(meal_plan.total_servings).to eq(standard_servings * qty_recipes)
    end

    it "returns zero if there are no recipes" do
      expect(meal_plan.total_servings).to eq(0)
    end
  end

  describe "#total_prep_time" do
    let(:meal_plan) { build(:meal_plan) }
    let(:standard_prep_time) { 2 }
    let(:qty_recipes) { 2 }

    it "returns a prep time total for all recipes in meal plan" do
      qty_recipes.times do
        meal_plan.recipes << create(:recipe, prep_time: standard_prep_time)
        meal_plan.save
      end
      expect(meal_plan.total_prep_time).to eq(standard_prep_time * qty_recipes)
    end

    it "returns zero if there are no recipes" do
      expect(meal_plan.total_prep_time).to eq(0)
    end
  end

  describe "#total_cook_time" do
    let(:meal_plan) { build(:meal_plan) }
    let(:standard_cook_time) { 2 }
    let(:qty_recipes) { 2 }

    it "returns a cook time total for all recipes in meal plan" do
      qty_recipes.times do
        meal_plan.recipes << create(:recipe, cook_time: standard_cook_time)
        meal_plan.save
      end

      expect(meal_plan.total_cook_time).to eq(standard_cook_time * qty_recipes)
    end

    it "returns zero if there are no recipes" do
      expect(meal_plan.total_cook_time).to eq(0)
    end
  end

  describe "#total_time" do
    let(:meal_plan) { build(:meal_plan) }
    let(:standard_cook_time) { 2 }
    let(:standard_prep_time) { 2 }
    let(:qty_recipes) { 2 }
    let(:total_standard_time) { (standard_cook_time + standard_prep_time) * qty_recipes }

    it "returns a time total for all recipes in meal plan" do
      qty_recipes.times do
        meal_plan.recipes << create(:recipe, prep_time: standard_prep_time, cook_time: standard_cook_time)
        meal_plan.save
      end

      expect(meal_plan.total_time).to eq(total_standard_time)
    end
  end

  describe "#estimated_time" do
    let(:meal_plan) { create(:meal_plan) }

    it "will output a time shorter than the total cook time" do
      minutes = 100
      rate = 0.5
      est_time = 50
      allow(meal_plan).to receive(:total_time).and_return(minutes)
      allow(meal_plan).to receive(:efficiency_rate).and_return(rate)

      expect(meal_plan.estimated_time).to be < meal_plan.total_time
      expect(meal_plan.estimated_time).to eq(est_time)
    end
  end

  describe "#recommended_start_time" do
    let(:meal_plan) { create(:meal_plan) }

    it "outputs in time format" do
      time = Time.zone.parse("12:00 PM")
      est_minutes = 60
      expected_time = Time.zone.parse("11:00 AM").strftime("%I:%M %p")
      allow(meal_plan).to receive(:prep_end_time).and_return(time)
      allow(meal_plan).to receive(:estimated_time).and_return(est_minutes)

      expect(meal_plan.recommended_start_time).to eq(expected_time)
    end

    xit "will never be later than MealPlan::PREP_END_TIME"
  end

  describe "#meals" do
    let(:meal_plan) { build(:meal_plan) }
    let(:standard_servings) { 2 }
    let(:qty_recipes) { 2 }
    let(:total_servings) { standard_servings * qty_recipes }
    let(:expected_qty) { total_servings / meal_plan.people_served }

    it "returns the number of servings for recipes divided by people served in a meal plan" do
      qty_recipes.times do
        meal_plan.recipes << create(:recipe, servings: standard_servings)
        meal_plan.save
      end
      expect(meal_plan.meals).to eq(expected_qty)
    end

    it "returns zero if there are no recipes" do
      expect(meal_plan.meals).to eq(0)
    end
  end

  describe "#total_unique_ingredients" do
    let(:meal_plan) { build(:meal_plan) }
    let(:qty_recipes) { 2 }
    let(:recipe1) { create(:recipe) }
    let(:recipe2) { create(:recipe) }
    let(:ingredient1) { build(:ingredient) }
    let(:ingredient2) { build(:ingredient) }

    it "returns a count of all unique ingredients used in meal plan" do
      recipe1.ingredients << ingredient1
      recipe1.save

      recipe2.ingredients << [ingredient1, ingredient2]
      recipe2.save

      meal_plan.recipes << [recipe1, recipe2]
      meal_plan.save
      expect(meal_plan.total_unique_ingredients).to eq(2)
    end
  end
end
