# frozen_string_literal: true

module ShoppingListsHelper
  def toggle_favorite(list)
    if list.favorite
      # Show the filled star and link to "unfavorite" it
      icon = MaterialIcon.new(icon: :star, filled: true, title: "Click to unfavorite", classes: "text-warning").render
      link_to icon, shopping_list_favorite_path(list), method: :delete
    else
      # Show the outlined star and link to "favorite" it
      icon = MaterialIcon.new(icon: :star, filled: false, title: "Click to favorite").render
      link_to icon, shopping_list_favorites_path(id: list.id), method: :post
    end
  end

  def display_item(item)
    "#{item.name} #{display_quantity(item)} #{display_upc(item)}"
  end

  def toggle_active_inactive_path(item)
    item.inactive? ? activate_item_path(id: item.id) : deactivate_item_path(id: item.id)
  end

  def scheduled_delivery_status(item)
    if item.active? && item.list.scheduled_deliveries.today_and_beyond.any?
      icon = MaterialIcon.new(
        icon: :add_shopping_cart,
        size: :large, classes: "js-add-to-cart",
        title: "Click to mark item as scheduled for home delivery."
      ).render

      return button_to(icon, add_to_cart_path(id: item.id), method: :post, class: "icon-button", remote: true)
    end

    if item.in_cart?
      icon = MaterialIcon.new(
        icon: :shopping_bag,
        size: :large, classes: "text-warning js-remove-from-cart",
        title: "Item is scheduled for home delivery. Click to remove."
      ).render

      button_to(icon, remove_from_cart_path(id: item.id), method: :post, class: "icon-button", remote: true)
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
      icon = MaterialIcon.new(
        icon: :event_repeat,
        size: :small,
        title: "Added automatically every #{item.recurrence_frequency}"
      ).render

      content_tag(:span, icon + " " + item.recurrence_frequency, class: "recurrence-tag")
    end
  end

  def display_upc(item)
    "##{item.heb_upc}" if item.heb_upc.present?
  end
end
