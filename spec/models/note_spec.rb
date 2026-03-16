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
require "rails_helper"

RSpec.describe Note, type: :model do
  let(:user) { build(:user) }

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    let(:note) { build(:note) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  describe "scopes" do
    describe "favorites" do
      it "returns only favorite notes" do
        user = User.create!(email: "test@example.com", password: "password")
        favorite_note = Note.create!(user: user, title: "Favorite Note", content: "Content", favorite: true)
        Note.create!(user: user, title: "Non-Favorite Note", content: "Content", favorite: false)

        expect(Note.favorites).to eq([favorite_note])
      end
    end
  end
end
