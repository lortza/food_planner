# frozen_string_literal: true

require Rails.root.join('db/seeds_helper.rb')

RSpec.describe 'SeedsHelper' do
  let(:seeds_helper) { Class.new { include SeedsHelper }.new }
  let(:user) { create(:user) }
  let(:recipe_data) do
    [{
      title: "Veggie Po'boy",
      source_name: 'Warm Kitchen',
      source_url: 'https://warmkitchen.wordpress.com/2014/11/12/its-a-veggie-po-boy-yall/',
      servings: 4,
      instructions: 'Cook stuff',
      prep_time: 10,
      cook_time: 20,
      image_url: 'http://cdn2.pepperplate.com/recipes/bcb751ba9ab749dbb0f48ffb083a72c5.jpg',
      reheat_time: 20,
      pepperplate_url: 'http://www.pepperplate.com/recipes/view.aspx?id=15454393',
      archived: false
    },
     {
       title: 'Quick Pad Thai',
       source_name: "Women's Health Magazine",
       source_url: 'https://subscribe.hearstmags.com/circulation/shared/index.html',
       servings: 4,
       instructions: 'Cook stuff',
       prep_time: 10,
       cook_time: 20,
       image_url: 'http://cdn2.pepperplate.com/recipes/dad9e72fa23f4e839c6057b8684da88e.jpg',
       reheat_time: 10,
       pepperplate_url: 'http://www.pepperplate.com/recipes/view.aspx?id=15772038',
       archived: false
     },]
  end
  let(:ingredient_data) do
    [{
      recipe_title: "Veggie Po'boy",
      quantity: 8.0,
      measurement_unit: 'slice',
      name: 'muenster cheese',
      preparation_style: 'sliced'
    },
     {
       recipe_title: 'Quick Pad Thai',
       quantity: 1.0,
       measurement_unit: 'cup',
       name: 'cucumber',
       preparation_style: 'sliced'
     },]
  end

  describe '#check_for_existing_data!' do
    subject(:check_for_existing_data!) { seeds_helper.check_for_existing_data! }

    context 'when no data exists' do
      it { expect { check_for_existing_data! }.not_to raise_error }
    end

    context 'when data already exists' do
      before { create(:user) }
      it { expect { check_for_existing_data! }.to raise_error('ExistingDataError') }
    end
  end

  describe '#assign_user_to_seed_data' do
    subject(:processed_data) { seeds_helper.assign_user_to_seed_data(recipe_data, user) }
    it 'assigns user' do
      expect(recipe_data.first[:user]).to be nil
      expect(processed_data.first[:user]).to eq(user)
    end
  end

  describe '#build_recipe_title_id_hash' do
    let!(:recipe) { create(:recipe, title: recipe_data.first[:title]) }
    let(:expected_hash) do
      {
        recipe_data.first[:title] => recipe.id,
        recipe_data.last[:title] => nil # recipe not found
      }
    end
    subject(:recipe_title_id_hash) { seeds_helper.build_recipe_title_id_hash(ingredient_data) }

    it 'returns a hash with recipe title as key and recipe id as value' do
      expect(recipe_title_id_hash).to eq(expected_hash)
    end
  end

  describe '#notify_if_missing_recipes' do
    let(:recipe_hash) { seeds_helper.build_recipe_title_id_hash(ingredient_data) }
    subject(:notifiy) { seeds_helper.notify_if_missing_recipes(ingredient_data, recipe_hash) }

    context 'with missing recipe' do
      it 'outputs notification if any ingredient is missing a matching recipe' do
        expect(STDOUT).to receive(:puts).with(SeedsHelper::MISSING_RECIPE_WARNING)
        notifiy
      end
    end

    context 'without missing recipe' do
      before do
        recipe_data.each { |recipe| create(:recipe, title: recipe[:title]) }
      end
      it 'does not output a message' do
        expect(STDOUT).not_to receive(:puts)
        notifiy
      end
    end
  end

  describe '#assign_recipe_to_seed_data' do
    let!(:recipe) { create(:recipe, title: recipe_data.first[:title]) }
    let(:recipe_title_id_hash) { { recipe.title => recipe.id } }
    subject(:processed_data) { seeds_helper.assign_recipe_to_seed_data(ingredient_data, recipe_title_id_hash) }

    it 'assigns recipe_id' do
      expect(processed_data.first[:recipe_id]).to eq(recipe.id)
    end
  end
end
