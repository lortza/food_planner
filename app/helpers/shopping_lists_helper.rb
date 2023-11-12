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
    "#{item.name} #{display_quantity(item)} #{display_upc(item)}"
  end

  def toggle_active_inactive_path(item)
    item.inactive? ? activate_item_path(id: item.id) : deactivate_item_path(id: item.id)
  end

  def scheduled_delivery_status(item)
    return button_to(MaterialIcon.new(icon: :add_shopping_cart, size: :large, classes: 'js-add-to-cart', title: 'Click to mark item as scheduled for home delivery.').render,
                    add_to_cart_path(id: item.id),
                    method: :post,
                    class: 'icon-button',
                    remote: true) if item.active? && item.list.scheduled_deliveries.future.any?

    return button_to(MaterialIcon.new(icon: :shopping_bag, size: :large, classes: 'text-warning js-remove-from-cart', title: 'Item is scheduled for home delivery. Click to remove.').render,
              remove_from_cart_path(id: item.id),
              method: :post,
              class: 'icon-button',
              remote: true) if item.in_cart?
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
