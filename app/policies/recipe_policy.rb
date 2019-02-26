class RecipePolicy < ApplicationPolicy
  def show?
    # allow only if the current_user on their own timeline
    record.user_id == user.id
  end
  def create?
    # allow only if the current_user on their own timeline
    record.user_id == user.id
  end
  def destroy?
    # allow only if the current_user on their own timeline
    record.user_id == user.id
  end
end
