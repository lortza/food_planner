class UserPolicy < ApplicationPolicy

  def edit?
    user_is_owner_of_record_or_admin?
  end

  def update?
    user_is_owner_of_record_or_admin?
  end

  def destroy?
    user_is_owner_of_record_or_admin?
  end

  def user_is_owner_of_record_or_admin?
    # only allow the current_user to edit their own profile
    # or allow admin user
    (record.id == user&.id) || user&.admin?
  end
end
