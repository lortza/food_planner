# frozen_string_literal: true

class ShoppingListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def show?
    user_is_owner_of_record_or_admin?
  end

  def create?
    user_is_owner_of_record_or_admin?
  end

  def edit?
    user_is_owner_of_record_or_admin?
  end

  def update?
    user_is_owner_of_record_or_admin?
  end

  def destroy?
    user_is_owner_of_record_or_admin? && record.default? == false
  end

  private

  def user_is_owner_of_record_or_admin?
    # only allow action to run if the current_user on their own shopping_list
    (record.user_id == user&.id) || user&.admin?
  end
end
