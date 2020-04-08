class RecipeSuggestion
  def initialize(inventory)
    @inventory_items = inventory.items
    @user = inventory.user
  end

  def suggest
    items = strip_items_list(@inventory_items)
    suggestions = {}

    items.each do |item|
      suggestions[item] = [] if suggestions[item].nil?

      matching_user_ingredients(item).each do |ingredient|
        suggestions[item] << ingredient.recipe
      end
    end # items each

    suggestions
  end # suggest

  private

  def matching_user_ingredients(item)
    Ingredient.includes([:recipe])
              .where(recipes: {user_id: @user.id})
              .where('name ilike ?', "%#{item}%")
  end

  def strip_items_list(list)
    list.downcase.split("\r\n").uniq.reject(&:empty?).map(&:strip)
  end
end
