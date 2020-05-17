# frozen_string_literal: true

module ShoppingListsHelper
  def toggle_favorite(list)
    if list.favorite
      # Show the filled star and link to "unfavorite" it
      link_to '', shopping_list_favorite_path(list),
              class: Icon.star_filled,
              method: :delete
    else
      # Show the outlined star and link to "favorite" it
      link_to '', shopping_list_favorites_path(id: list.id),
              class: Icon.star_outline,
              method: :post
    end
  end

  def display_item(item)
    "#{item.name} #{display_quantity(item)} #{display_upc(item)} #{display_recurrence(item)}".html_safe
  end

  def display_status(item)
    # "<span class='material-icons in-cart'>shopping_cart</span>"
    tag = <<~TAG
      <span class='status-tag js-remove-from-cart'>
        <span class='material-icons-outlined in-cart' title='Item is purchased and scheduled for home delivery'>
          shopping_cart
        </span>
      </span>
    TAG
    tag.html_safe if item.in_cart?
  end

  private

  def display_quantity(item)
    quantity = item.quantity

    pretty_number = NumbersHelper.prettify_float(quantity)
    "(#{pretty_number})" if quantity != 1
  end

  def display_recurrence(item)
    return if item.recurrence_frequency.blank?

    "<span class='recurrence-tag'><span class='#{Icon.sync}'></span> #{item.recurrence_frequency}</span>"
  end

  def display_upc(item)
    "##{item.heb_upc}" if item.heb_upc.present?
  end
end
