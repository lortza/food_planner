# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :experimental_recipes, dependent: :destroy
  has_many :meal_plans, dependent: :destroy
  has_many :shopping_lists, dependent: :destroy
  has_many :aisles, dependent: :destroy

  after_create :populate_defaults

  def favorite_list
    shopping_lists.find_by(favorite: true)
  end

  private

  def populate_defaults
    UserSetup.populate_shopping_lists(self)
    UserSetup.populate_aisles(self)
  end
end
