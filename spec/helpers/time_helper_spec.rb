# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeHelper, type: :helper do
  describe 'self.display_time' do
    it 'displays time as minutes if less than 60' do
      displayed_time = TimeHelper.display_time(55)
      expect(displayed_time).to eq('55m')
    end

    it 'displays time as min if 60 min' do
      displayed_time = TimeHelper.display_time(60)
      expect(displayed_time).to eq('60m')
    end

    it 'displays time as hour/min if 60 min or more' do
      displayed_time = TimeHelper.display_time(120)
      expect(displayed_time).to eq('2h 0m')
    end
  end
end
