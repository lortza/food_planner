# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NumbersHelper, type: :helper do
  describe 'self.whole_number?' do
    it 'returns true if a float is a whole number' do
      expect(NumbersHelper.whole_number?(1.0)).to eq(true)
    end

    it 'returns false if a float is not a whole number' do
      expect(NumbersHelper.whole_number?(1.1)).to eq(false)
    end
  end

  describe 'self.prettify_float' do
    it 'returns a whole number float as an integer' do
      expect(NumbersHelper.prettify_float(1.0)).to eq(1)
    end

    it 'returns a float with a .0 greater than 0 as a float' do
      expect(NumbersHelper.prettify_float(1.5)).to eq(1.5)
    end
  end
end
