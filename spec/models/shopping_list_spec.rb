# frozen_string_literal: true

RSpec.describe ShoppingList, type: :model do
  let(:shopping_list) { build(:shopping_list) }

  context "associations" do
    it { should belong_to(:user) }
    it { should have_many(:shopping_list_items) }
    it { should have_many(:items) }
    it { should have_many(:scheduled_deliveries) }
  end

  describe "a valid shopping_list" do
    context "when has valid params" do
      it "is valid" do
        expect(shopping_list).to be_valid
      end

      it { should validate_presence_of(:name) }

      it "validates that names are unique" do
        create(:shopping_list, name: "grocery")
        should validate_uniqueness_of(:name).case_insensitive
      end
    end
  end

  describe "normalization" do
    it "strips leading/trailing blankspace and squishes internal blankspace in the name" do
      shopping_list = build(:shopping_list, name: "  My   Shopping   list  ")
      expect(shopping_list.valid?).to be(true)
      expect(shopping_list.name).to eq("My Shopping list")
    end
  end

  describe "self.default" do
    let(:user) { create(:user) }
    let(:shopping_list) { create(:shopping_list, user: user) }

    it 'returns the existing shopping list called "grocery" that belongs to the current_user' do
      existing_list = create(:shopping_list, user: user, name: "grocery", main: true)
      returned_list = user.shopping_lists.default

      expect(returned_list).to eq(existing_list)
    end
  end

  describe ".by_favorite" do
    it "returns results with the favorite first" do
      favorite_list = create(:shopping_list, favorite: true)
      create(:shopping_list, favorite: false)
      ordered_lists = ShoppingList.by_favorite

      expect(ordered_lists.first).to eq(favorite_list)
    end
  end

  describe "active_items_by_aisle" do
    let(:list) { create(:shopping_list) }
    let(:aisle) { create(:aisle) }

    it "includes active items" do
      item = create(:shopping_list_item, shopping_list: list, aisle: aisle, status: "active")
      expect(list.active_items_by_aisle[aisle]).to include(item)
    end

    it "includes in_cart items" do
      item = create(:shopping_list_item, shopping_list: list, aisle: aisle, status: "in_cart")
      expect(list.active_items_by_aisle[aisle]).to include(item)
    end

    it "excludes inactive items" do
      create(:shopping_list_item, shopping_list: list, aisle: aisle, status: "inactive")
      expect(list.active_items_by_aisle[aisle]).to be_nil
    end

    it "groups items by aisle" do
      other_aisle = create(:aisle)
      item_in_aisle = create(:shopping_list_item, shopping_list: list, aisle: aisle, status: "active")
      item_in_other_aisle = create(:shopping_list_item, shopping_list: list, aisle: other_aisle, status: "active")

      result = list.active_items_by_aisle

      expect(result[aisle]).to include(item_in_aisle)
      expect(result[other_aisle]).to include(item_in_other_aisle)
    end
  end

  describe "active_items" do
    let(:list) { create(:shopping_list) }

    it "includes active items" do
      item = create(:shopping_list_item, shopping_list: list, status: "active")
      expect(list.active_items).to include(item)
    end

    it "includes in_cart items" do
      item = create(:shopping_list_item, shopping_list: list, status: "in_cart")
      expect(list.active_items).to include(item)
    end

    it "excludes inactive items" do
      item = create(:shopping_list_item, shopping_list: list, status: "inactive")
      expect(list.active_items).not_to include(item)
    end

    it "returns items sorted by name" do
      item_b = create(:shopping_list_item, shopping_list: list, name: "Bananas", status: "active")
      item_a = create(:shopping_list_item, shopping_list: list, name: "Apples", status: "active")

      expect(list.active_items.to_a).to eq([item_a, item_b])
    end
  end

  describe "#favorite!" do
    it 'sets the "favorite" attribute to true and saves the list' do
      list = create(:shopping_list, favorite: false)
      list.favorite!

      expect(list.favorite).to eq(true)
    end
  end

  describe "#unfavorite!" do
    it 'sets the "favorite" attribute to false and saves the list' do
      list = create(:shopping_list, favorite: true)
      list.unfavorite!

      expect(list.favorite).to eq(false)
    end
  end

  describe "default?" do
    it 'returns true if it is the "main" list' do
      list = build(:shopping_list, main: true)
      expect(list.default?).to be(true)
    end

    it "returns false if it is any other list" do
      list = build(:shopping_list)
      expect(list.default?).to be(false)
    end
  end

  describe "deletable?" do
    it 'returns false if it is the "main" list' do
      list = build(:shopping_list, main: true)
      expect(list.deletable?).to be(false)
    end

    it "returns true if it is any other list" do
      list = build(:shopping_list)
      expect(list.deletable?).to be(true)
    end
  end
end
