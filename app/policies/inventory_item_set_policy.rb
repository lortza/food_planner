# frozen_string_literal: true

class InventoryItemSetPolicy < ApplicationPolicy
  def index?
    (record.user.id == user&.id) || user&.admin?
  end
end
