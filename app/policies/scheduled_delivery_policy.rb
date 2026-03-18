# frozen_string_literal: true

class ScheduledDeliveryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:shopping_list).where(shopping_lists: {user_id: user.id})
    end
  end

  def new?
    user_is_owner_of_shopping_list_or_admin?
  end

  def create?
    user_is_owner_of_shopping_list_or_admin?
  end

  def edit?
    user_is_owner_of_shopping_list_or_admin?
  end

  def update?
    user_is_owner_of_shopping_list_or_admin?
  end

  def destroy?
    user_is_owner_of_shopping_list_or_admin?
  end

  private

  def user_is_owner_of_shopping_list_or_admin?
    record.shopping_list.user_id == user&.id || user&.admin?
  end
end
