# == Schema Information
#
# Table name: notes
#
#  id         :uuid             not null, primary key
#  content    :text             default(""), not null
#  favorite   :boolean          default(FALSE), not null
#  title      :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_notes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Note < ApplicationRecord
  extend Searchable

  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  scope :favorites, -> { where(favorite: true) }
end
