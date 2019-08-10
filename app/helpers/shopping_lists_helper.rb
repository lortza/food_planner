# frozen_string_literal: true

module ShoppingListsHelper
  def toggle_favorite(list)
    if list.favorite
      # Show the ★ and link to "unfavorite" it
      link_to '', shopping_list_favorite_path(list),
                  class: Icon.star_filled,
                  method: :delete
    else
      # Show the ☆ and link to "favorite" it
      link_to '', shopping_list_favorites_path(id: list.id),
                  class: Icon.star_outline,
                  method: :post
    end
  end
end
