# frozen_string_literal: true

RSpec.describe Tag, type: :model do
  let(:tag) { build(:tag, user: user) }
  let(:user) { create(:user) }

  context "associations" do
    it { should belong_to(:user) }
    it { should have_many(:recipe_tags) }
    it { should have_many(:recipes).through(:recipe_tags) }
  end

  describe "a valid tag" do
    context "when has valid params" do
      it "is valid" do
        expect(tag).to be_valid
      end
    end

    it { should validate_presence_of(:name) }

    describe "name uniqueness" do
      let(:user_1) { create(:user) }
      let(:user_2) { create(:user) }

      it 'considers "FOO" and "foo" to be the same name' do
        create(:tag, user_id: user_1.id, name: "FOO")
        tag_2 = build(:tag, user_id: user_1.id, name: "foo")
        expect(tag_2.valid?).to be(false)
      end

      it "does not permit the same user to have multiple tags with the same name" do
        create(:tag, user_id: user_1.id, name: "Foo")
        tag_2 = build(:tag, user_id: user_1.id, name: "Foo")
        expect(tag_2.valid?).to be(false)
      end

      it "permits multiple users to have the same tag name" do
        create(:tag, user_id: user_1.id, name: "Foo")
        tag_2 = build(:tag, user_id: user_2.id, name: "Foo")
        expect(tag_2.valid?).to be(true)
      end
    end
  end

  describe "normalization" do
    it "strips leading/trailing whitespace and downcases the name before validation" do
      tag = build(:tag, user: user, name: "  ExAmPlE TaG  ")
      expect(tag.valid?).to be(true)
      expect(tag.name).to eq("example tag")
    end

    it "gracefully handles nil name" do
      tag = build(:tag, user: user, name: nil)
      expect(tag.valid?).to be(false)
      expect(tag.errors[:name]).to include("can't be blank")
    end
  end
end
