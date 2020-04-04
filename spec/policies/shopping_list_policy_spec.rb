require 'rails_helper'

RSpec.describe ShoppingListPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:shopping_list) { create(:shopping_list, user: user) }

  subject { ShoppingListPolicy }

  permissions :show? do
    it 'denies access to visitors' do
      no_user = nil
      expect(subject).not_to permit(no_user, shopping_list)
    end

    it 'denies access to non-author users' do
      different_user = create(:user)
      expect(subject).not_to permit(different_user, shopping_list)
    end

    it 'permits access to author users' do
      expect(subject).to permit(user, shopping_list)
    end

    it 'permits access to non-author admin users' do
      admin = create(:user, admin: true)
      expect(subject).to permit(admin, shopping_list)
    end
  end

  permissions :create? do
    it 'denies access to visitors' do
      no_user = nil
      expect(subject).not_to permit(no_user, shopping_list)
    end

    it 'denies access to non-author users' do
      different_user = create(:user)
      expect(subject).not_to permit(different_user, shopping_list)
    end

    it 'permits access to author users' do
      expect(subject).to permit(user, shopping_list)
    end

    it 'permits access to non-author admin users' do
      admin = create(:user, admin: true)
      expect(subject).to permit(admin, shopping_list)
    end
  end

  permissions :edit? do
    it 'denies access to visitors' do
      no_user = nil
      expect(subject).not_to permit(no_user, shopping_list)
    end

    it 'denies access to non-author users' do
      different_user = create(:user)
      expect(subject).not_to permit(different_user, shopping_list)
    end

    it 'permits access to author users' do
      expect(subject).to permit(user, shopping_list)
    end

    it 'permits access to non-author admin users' do
      admin = create(:user, admin: true)
      expect(subject).to permit(admin, shopping_list)
    end
  end

  permissions :update? do
    it 'denies access to visitors' do
      no_user = nil
      expect(subject).not_to permit(no_user, shopping_list)
    end

    it 'denies access to non-author users' do
      different_user = create(:user)
      expect(subject).not_to permit(different_user, shopping_list)
    end

    it 'permits access to author users' do
      expect(subject).to permit(user, shopping_list)
    end

    it 'permits access to non-author admin users' do
      admin = create(:user, admin: true)
      expect(subject).to permit(admin, shopping_list)
    end
  end

  permissions :destroy? do
    it 'denies access to visitors' do
      no_user = nil
      expect(subject).not_to permit(no_user, shopping_list)
    end

    it 'denies access to non-author users' do
      different_user = create(:user)
      expect(subject).not_to permit(different_user, shopping_list)
    end

    it 'permits access to author users' do
      expect(subject).to permit(user, shopping_list)
    end

    it 'permits access to non-author admin users' do
      admin = create(:user, admin: true)
      expect(subject).to permit(admin, shopping_list)
    end
  end
end
