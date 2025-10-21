# frozen_string_literal: true

class TagPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def index?
    user.present?
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
    user_is_owner_of_record_or_admin?
  end
end
