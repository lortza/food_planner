# frozen_string_literal: true

class InventoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def edit?
    user_is_owner_of_record_or_admin?
  end

  def update?
    user_is_owner_of_record_or_admin?
  end

  private

  def user_is_owner_of_record_or_admin?
    # only allow action to run if the current_user on their own recipe
    (record.user_id == user&.id) || user&.admin?
  end
end
