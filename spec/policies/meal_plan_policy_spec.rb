# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MealPlanPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:meal_plan) { create(:meal_plan, user: user) }

  subject { MealPlanPolicy }

  permissions :show? do
    it 'denies access to visitors' do
      no_user = nil
      expect(subject).not_to permit(no_user, meal_plan)
    end

    it 'denies access to non-author users' do
      different_user = create(:user)
      expect(subject).not_to permit(different_user, meal_plan)
    end

    it 'permits access to author users' do
      expect(subject).to permit(user, meal_plan)
    end

    it 'permits access to non-author admin users' do
      admin = create(:user, admin: true)
      expect(subject).to permit(admin, meal_plan)
    end
  end

  permissions :create? do
    it 'denies access to visitors' do
      no_user = nil
      expect(subject).not_to permit(no_user, meal_plan)
    end

    it 'denies access to non-author users' do
      different_user = create(:user)
      expect(subject).not_to permit(different_user, meal_plan)
    end

    it 'permits access to author users' do
      expect(subject).to permit(user, meal_plan)
    end

    it 'permits access to non-author admin users' do
      admin = create(:user, admin: true)
      expect(subject).to permit(admin, meal_plan)
    end
  end

  permissions :edit? do
    it 'denies access to visitors' do
      no_user = nil
      expect(subject).not_to permit(no_user, meal_plan)
    end

    it 'denies access to non-author users' do
      different_user = create(:user)
      expect(subject).not_to permit(different_user, meal_plan)
    end

    it 'permits access to author users' do
      expect(subject).to permit(user, meal_plan)
    end

    it 'permits access to non-author admin users' do
      admin = create(:user, admin: true)
      expect(subject).to permit(admin, meal_plan)
    end
  end

  permissions :update? do
    it 'denies access to visitors' do
      no_user = nil
      expect(subject).not_to permit(no_user, meal_plan)
    end

    it 'denies access to non-author users' do
      different_user = create(:user)
      expect(subject).not_to permit(different_user, meal_plan)
    end

    it 'permits access to author users' do
      expect(subject).to permit(user, meal_plan)
    end

    it 'permits access to non-author admin users' do
      admin = create(:user, admin: true)
      expect(subject).to permit(admin, meal_plan)
    end
  end

  permissions :destroy? do
    it 'denies access to visitors' do
      no_user = nil
      expect(subject).not_to permit(no_user, meal_plan)
    end

    it 'denies access to non-author users' do
      different_user = create(:user)
      expect(subject).not_to permit(different_user, meal_plan)
    end

    it 'permits access to author users' do
      expect(subject).to permit(user, meal_plan)
    end

    it 'permits access to non-author admin users' do
      admin = create(:user, admin: true)
      expect(subject).to permit(admin, meal_plan)
    end
  end
end
