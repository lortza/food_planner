# frozen_string_literal: true

class NotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
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
