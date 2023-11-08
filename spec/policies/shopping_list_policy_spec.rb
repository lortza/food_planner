# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShoppingListPolicy, type: :policy do
  let(:author) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:shopping_list) { create(:shopping_list, user: author) }

  subject { ShoppingListPolicy }

  permissions :show? do
    describe 'denies access to...' do
      it 'visitors' do
        no_user = nil
        expect(subject).not_to permit(no_user, shopping_list)
      end

      it 'non-author users' do
        different_user = create(:user)
        expect(subject).not_to permit(different_user, shopping_list)
      end
    end

    describe 'permits access to...' do
      it 'author users' do
        expect(subject).to permit(author, shopping_list)
      end

      it 'non-author admin users' do
        # admin = create(:user, admin: true)
        expect(subject).to permit(admin, shopping_list)
      end
    end
  end

  permissions :create? do
    describe 'denies access to...' do
      it 'visitors' do
        no_user = nil
        expect(subject).not_to permit(no_user, shopping_list)
      end

      it 'non-author users' do
        different_user = create(:user)
        expect(subject).not_to permit(different_user, shopping_list)
      end
    end

    describe 'permits access to...' do
      it 'author users' do
        expect(subject).to permit(author, shopping_list)
      end

      it 'non-author admin users' do
        # admin = create(:user, admin: true)
        expect(subject).to permit(admin, shopping_list)
      end
    end
  end

  permissions :edit? do
    describe 'denies access to...' do
      it 'visitors' do
        no_user = nil
        expect(subject).not_to permit(no_user, shopping_list)
      end

      it 'non-author users' do
        different_user = create(:user)
        expect(subject).not_to permit(different_user, shopping_list)
      end
    end

    describe 'permits access to...' do
      it 'author users' do
        expect(subject).to permit(author, shopping_list)
      end

      it 'non-author admin users' do
        # admin = create(:user, admin: true)
        expect(subject).to permit(admin, shopping_list)
      end
    end
  end

  permissions :update? do
    describe 'denies access to...' do
      it 'visitors' do
        no_user = nil
        expect(subject).not_to permit(no_user, shopping_list)
      end

      it 'non-author users' do
        different_user = create(:user)
        expect(subject).not_to permit(different_user, shopping_list)
      end
    end

    describe 'permits access to...' do
      it 'author users' do
        expect(subject).to permit(author, shopping_list)
      end

      it 'non-author admin users' do
        # admin = create(:user, admin: true)
        expect(subject).to permit(admin, shopping_list)
      end
    end
  end

  permissions :destroy? do
    describe 'it denies access to...' do
      it 'visitors' do
        no_user = nil
        expect(subject).not_to permit(no_user, shopping_list)
      end

      it 'non-author users' do
        different_user = create(:user)
        expect(subject).not_to permit(different_user, shopping_list)
      end
    end

    describe 'it permits access to...' do
      it 'author users' do
        expect(subject).to permit(author, shopping_list)
      end

      it 'non-author admin users' do
        # admin = create(:user, admin: true)
        expect(subject).to permit(admin, shopping_list)
      end
    end

    describe 'default shopping list ("Grocery")' do
      let(:default_shopping_list) { create(:shopping_list, user: author, main: true) }

      it 'it denies authors' do
        expect(subject).not_to permit(author, default_shopping_list)
      end

      it 'denies non-author admin' do
        # admin = create(:user, admin: true)
        expect(subject).not_to permit(admin, default_shopping_list)
      end

      it 'denies author admin' do
        admin_author = create(:user, admin: true)
        default_shopping_list = create(:shopping_list, user: admin_author, main: true)

        expect(subject).not_to permit(admin_author, default_shopping_list)
      end
    end
  end
end
