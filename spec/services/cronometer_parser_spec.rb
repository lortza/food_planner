# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CronometerParser, type: :service do
  let(:parser) { CronometerParser.new(valid_iframe_code) }
  let(:valid_iframe_code) { "<iframe title=\'CRONOMETER.com\' width=\'320\' height=\'540\' src=\'https://cronometer.com/facts.html?#{food_arg}&#{measure_arg}&labelType=AMERICAN\' frameborder=\'0\'></iframe>" }
  let(:valid_food_arg) { 'food=12345678' }
  let(:valid_measure_arg) { 'measure=87654321' }
  let(:food_arg) { valid_food_arg }
  let(:measure_arg) { valid_measure_arg }

  describe 'valid_iframe_data?' do
    describe 'when the food_number is present and the measure_number is present' do
      it 'returns true' do
        allow(parser).to receive(:food_number).and_return('12345678')
        allow(parser).to receive(:measure_number).and_return('87654321')
        expect(parser.valid_iframe_data?).to be(true)
      end
    end

    describe 'when the food_number is present and the measure_number is NOT present' do
      it 'returns true' do
        allow(parser).to receive(:food_number).and_return('12345678')
        allow(parser).to receive(:measure_number).and_return(nil)
        expect(parser.valid_iframe_data?).to be(false)
      end
    end

    describe 'when the food_number is NOT present and the measure_number is present' do
      it 'returns true' do
        allow(parser).to receive(:food_number).and_return(nil)
        allow(parser).to receive(:measure_number).and_return('87654321')
        expect(parser.valid_iframe_data?).to be(false)
      end
    end

    describe 'when the food_number is NOT present and the measure_number is NOT present' do
      it 'returns true' do
        allow(parser).to receive(:food_number).and_return(nil)
        allow(parser).to receive(:measure_number).and_return(nil)
        expect(parser.valid_iframe_data?).to be(false)
      end
    end
  end

  describe 'sanitized_iframe_src' do
    describe 'when the required data is valid' do
      it 'returns the expected url' do
        allow(parser).to receive(:valid_iframe_data?).and_return(true)
        expected_url = "https://cronometer.com/facts.html?food=12345678&measure=87654321&labelType=AMERICAN"
        expect(parser.sanitized_iframe_src).to eq(expected_url)
      end
    end

    describe 'when the required data is not valid' do
      it 'returns nil' do
        allow(parser).to receive(:valid_iframe_data?).and_return(false)
        expect(parser.sanitized_iframe_src).to be(nil)
      end
    end
  end

  describe 'private matching methods' do
    let(:invalid_iframe_code) { 'oh hi there & good day&to you' }

    describe 'private.food_number' do
      describe 'when there is no food argument or data' do
        let(:food_arg) { '' }
        it 'returns nil' do
          expect(parser.send(:food_number)).to be(nil)
        end
      end

      describe 'when the food arg is present, but there is no data' do
        let(:food_arg) { 'food=' }
        it 'returns nil' do
          expect(parser.send(:food_number)).to be(nil)
        end
      end

      describe 'when the food data is not a number' do
        let(:food_arg) { 'food=foosbars' }
        it 'returns nil' do
          expect(parser.send(:food_number)).to be(nil)
        end
      end

      describe 'when the food data is a mix of numbers and characters' do
        let(:food_arg) { 'food=f00sb44rs' }
        it 'returns nil' do
          expect(parser.send(:food_number)).to be(nil)
        end
      end

      describe 'when there is a match' do
        it 'returns 12345678 as its value' do
          expect(parser.send(:food_number)).to eq('12345678')
        end
      end
    end

    describe 'private.measure_number' do
      describe 'when there is no measure argument or data' do
        let(:measure_arg) { '' }
        it 'returns nil' do
          expect(parser.send(:measure_number)).to be(nil)
        end
      end

      describe 'when the measure arg is present, but there is no data' do
        let(:measure_arg) { 'measure=' }
        it 'returns nil' do
          expect(parser.send(:measure_number)).to be(nil)
        end
      end

      describe 'when the measure data is not a number' do
        let(:measure_arg) { 'measure=foosbars' }
        it 'returns nil' do
          expect(parser.send(:measure_number)).to be(nil)
        end
      end

      describe 'when the measure data is a mix of numbers and characters' do
        let(:measure_arg) { 'measure=f00sb44rs' }
        it 'returns nil' do
          expect(parser.send(:measure_number)).to be(nil)
        end
      end

      describe 'when there is a match' do
        it 'returns 87654321 as its value' do
          expect(parser.send(:measure_number)).to eq('87654321')
        end
      end
    end
  end
end
