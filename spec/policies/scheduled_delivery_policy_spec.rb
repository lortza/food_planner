# frozen_string_literal: true

require "rails_helper"

RSpec.describe ScheduledDeliveryPolicy, type: :policy do
  let(:owner) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:other_user) { create(:user) }
  let(:shopping_list) { create(:shopping_list, user: owner) }
  let(:scheduled_delivery) { create(:scheduled_delivery, shopping_list: shopping_list) }

  subject { ScheduledDeliveryPolicy }

  permissions :new? do
    describe "denies access to..." do
      it "visitors" do
        expect(subject).not_to permit(nil, scheduled_delivery)
      end

      it "non-owner users" do
        expect(subject).not_to permit(other_user, scheduled_delivery)
      end
    end

    describe "permits access to..." do
      it "shopping list owner" do
        expect(subject).to permit(owner, scheduled_delivery)
      end

      it "admin users" do
        expect(subject).to permit(admin, scheduled_delivery)
      end
    end
  end

  permissions :create? do
    describe "denies access to..." do
      it "visitors" do
        expect(subject).not_to permit(nil, scheduled_delivery)
      end

      it "non-owner users" do
        expect(subject).not_to permit(other_user, scheduled_delivery)
      end
    end

    describe "permits access to..." do
      it "shopping list owner" do
        expect(subject).to permit(owner, scheduled_delivery)
      end

      it "admin users" do
        expect(subject).to permit(admin, scheduled_delivery)
      end
    end
  end

  permissions :edit? do
    describe "denies access to..." do
      it "visitors" do
        expect(subject).not_to permit(nil, scheduled_delivery)
      end

      it "non-owner users" do
        expect(subject).not_to permit(other_user, scheduled_delivery)
      end
    end

    describe "permits access to..." do
      it "shopping list owner" do
        expect(subject).to permit(owner, scheduled_delivery)
      end

      it "admin users" do
        expect(subject).to permit(admin, scheduled_delivery)
      end
    end
  end

  permissions :update? do
    describe "denies access to..." do
      it "visitors" do
        expect(subject).not_to permit(nil, scheduled_delivery)
      end

      it "non-owner users" do
        expect(subject).not_to permit(other_user, scheduled_delivery)
      end
    end

    describe "permits access to..." do
      it "shopping list owner" do
        expect(subject).to permit(owner, scheduled_delivery)
      end

      it "admin users" do
        expect(subject).to permit(admin, scheduled_delivery)
      end
    end
  end

  permissions :destroy? do
    describe "denies access to..." do
      it "visitors" do
        expect(subject).not_to permit(nil, scheduled_delivery)
      end

      it "non-owner users" do
        expect(subject).not_to permit(other_user, scheduled_delivery)
      end
    end

    describe "permits access to..." do
      it "shopping list owner" do
        expect(subject).to permit(owner, scheduled_delivery)
      end

      it "admin users" do
        expect(subject).to permit(admin, scheduled_delivery)
      end
    end
  end

  describe "Scope" do
    let(:other_shopping_list) { create(:shopping_list, user: other_user) }
    let!(:owner_delivery) { create(:scheduled_delivery, shopping_list: shopping_list) }
    let!(:other_delivery) { create(:scheduled_delivery, shopping_list: other_shopping_list) }

    it "returns only deliveries belonging to the user's shopping lists" do
      resolved = ScheduledDeliveryPolicy::Scope.new(owner, ScheduledDelivery.all).resolve
      expect(resolved).to include(owner_delivery)
      expect(resolved).not_to include(other_delivery)
    end

    it "does not return deliveries from other users' shopping lists for admin" do
      admin_list = create(:shopping_list, user: admin)
      admin_delivery = create(:scheduled_delivery, shopping_list: admin_list)
      resolved = ScheduledDeliveryPolicy::Scope.new(admin, ScheduledDelivery.all).resolve
      expect(resolved).to include(admin_delivery)
      expect(resolved).not_to include(owner_delivery, other_delivery)
    end
  end
end
