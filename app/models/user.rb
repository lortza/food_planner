# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :meal_plans, dependent: :destroy
  has_many :shopping_lists, dependent: :destroy
  has_many :aisles, dependent: :destroy

  def favorite_list
    shopping_lists.find_by(favorite: true)
  end
end
