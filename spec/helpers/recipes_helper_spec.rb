# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipesHelper, type: :helper do
  describe 'guaranteed_image' do
    let(:recipe) { build(:recipe, image_url: '') }
    it 'ensures an image file is returned' do
      expect(helper.guaranteed_image(recipe)).to eq('recipe_placeholder.jpg')
    end
  end

  describe 'status_flag' do
    xit 'returns a status flag of ___ when ____' do
    end
  end
end
