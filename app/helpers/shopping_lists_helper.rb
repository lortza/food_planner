# frozen_string_literal: true

module ShoppingListsHelper
  def toggle_favorite(list)
    if list.favorite
      # Show the filled star and link to "unfavorite" it
      link_to MaterialIcon.new(icon: :star_filled, classes: 'text-warning').render,
        shopping_list_favorite_path(list), method: :delete
    else
      # Show the outlined star and link to "favorite" it
      link_to MaterialIcon.new(icon: :star_outline).render,
        shopping_list_favorites_path(id: list.id), method: :post
    end
  end

  def display_item(item)
    # rubocop disable: Rails/OutputSafety
    "#{item.name} #{display_quantity(item)} #{display_upc(item)} #{display_recurrence(item)}".html_safe
    # rubocop enable: Rails/OutputSafety
  end

  def display_in_cart_status(item)
    if item.in_cart?
      content_tag(:span,
        MaterialIcon.new(icon: :shopping_cart,
          title: 'Item is purchased and scheduled for home delivery',
          classes: 'in-cart').render,
        class: 'status-tag js-remove-from-cart')
    end
  end

  private

  def display_quantity(item)
    quantity = item.quantity

    pretty_number = NumbersHelper.prettify_float(quantity)
    "(#{pretty_number})" if quantity != 1
  end

  def display_recurrence(item)
    unless item.recurrence_frequency.blank?
      content_tag(:span,
        MaterialIcon.new(
          icon: :event_repeat,
          size: :small,
          title: "Added automatically every #{item.recurrence_frequency}"
        ).render + ' ' + item.recurrence_frequency,
        class: 'recurrence-tag')
    end
  end

  def display_upc(item)
    "##{item.heb_upc}" if item.heb_upc.present?
  end
end
