# frozen_string_literal: true

class MaterialIcon
  # https://fonts.google.com/icons
  include ActionView::Helpers::TagHelper

  def initialize(icon:, title: nil, size: :inherit, filled: false, classes: nil)
    @icon = icon
    @title = title
    @size = size
    @filled = filled ? "icon-filled" : "icon-outlined"
    @provided_classes = classes
  end

  def render
    case @icon
    when :add_shopping_cart then add_shopping_cart
    when :archived then archived
    when :arrow_left then arrow_left
    when :calendar_clock then calendar_clock
    when :checkmark then checkmark
    when :clock then clock
    when :copy then copy
    when :convert then convert
    when :edit then edit_note
    when :event_repeat then event_repeat
    when :info then info
    when :new then new_release
    when :plus_circle then plus_circle
    when :plus_square then plus_square
    when :quick_reference then quick_reference
    when :search then search
    when :settings then settings
    when :shopping_bag then shopping_bag
    when :shopping_cart then shopping_cart
    when :star then star
    when :sync then sync
    when :trash then trash
    when :truck then truck
    else
      raise "ERROR: There is no ':#{@icon}' icon. See app/components/material_icon.rb for icon options."
    end
  end

  private

  def add_shopping_cart
    content_tag(:span, "add_shopping_cart",
      class: symbol_classes,
      title: @title.presence || "Add to cart")
  end

  def arrow_left
    content_tag(:span, "arrow_back",
      class: "#{symbol_classes} nav-link-icon left",
      title: @title.presence || "Back")
  end

  def archived
    content_tag(:span, "inventory_2",
      class: symbol_classes,
      title: @title.presence || "Archived")
  end

  def calendar_clock
    content_tag(:span, "calendar_clock",
      class: "#{symbol_classes} text-warning",
      title: @title.presence || "It's been a while")
  end

  def clock
    content_tag(:span, "update",
      class: symbol_classes,
      title: @title.presence || "Duration warning")
  end

  def checkmark
    content_tag(:span, "done",
      class: symbol_classes,
      title: @title.presence || "Done")
  end

  def convert
    content_tag(:span, "convert_to_text",
      class: symbol_classes,
      title: @title.presence || "Convert")
  end

  def copy
    content_tag(:span, "file_copy",
      class: symbol_classes,
      title: @title.presence || "Copy")
  end

  def edit_note
    content_tag(:span, "edit_note",
      class: "#{symbol_classes} float-right",
      title: @title.presence || "Edit")
  end

  def event_repeat
    content_tag(:span, "event_repeat",
      class: symbol_classes,
      title: @title.presence || "Repeated")
  end

  def info
    content_tag(:span, "info",
      class: symbol_classes,
      title: @title.presence || "Info")
  end

  def new_release
    content_tag(:span, "new_releases",
      class: symbol_classes,
      title: @title.presence || "New")
  end

  def plus_circle
    content_tag(:span, "add_circle",
      class: symbol_classes,
      title: @title.presence || "Add")
  end

  def plus_square
    content_tag(:span, "add_box",
      class: symbol_classes,
      title: @title.presence || "Add to list")
  end

  def quick_reference
    content_tag(:span, "quick_reference",
      class: symbol_classes,
      title: @title.presence || "Learn more")
  end

  def shopping_bag
    content_tag(:span, "shopping_bag",
      class: icon_classes,
      title: @title.presence || "In shopping bag")
  end

  def shopping_cart
    content_tag(:span, "shopping_cart",
      class: icon_classes,
      title: @title.presence || "Cart")
  end

  def star
    content_tag(:span, "star",
      class: symbol_classes,
      title: @title.presence || "Star")
  end

  def settings
    content_tag(:span, "settings",
      class: symbol_classes,
      title: @title.presence || "Settings")
  end

  def search
    content_tag(:span, "search",
      class: symbol_classes,
      title: @title.presence || "Search",
      aria: {hidden: true})
  end

  def sync
    content_tag(:span, "sync",
      class: symbol_classes,
      title: @title.presence || "Sync")
  end

  def trash
    content_tag(:span, "delete",
      class: symbol_classes,
      title: @title.presence || "Delete")
  end

  def truck
    content_tag(:span, "local_shipping",
      class: symbol_classes,
      title: @title.presence || "Delivery")
  end

  def size_class
    case @size
    when :xsmall then "text-xsmall"
    when :small then "text-small"
    when :medium then "text-medium"
    when :large then "text-large"
    when :xlarge then "text-xlarge"
    when :xxlarge then "text-xxlarge"
    when :inherit then "text-size-inherit"
    else
      raise "ERROR: Available sizes are :xsmall, :small, :medium, :large, :xlarge, :xxlarge, :inherit"
    end
  end

  def symbol_classes
    "material-symbols-outlined #{computed_classes}"
  end

  def icon_classes
    # icon classes do not support "filled"
    "material-icons-outlined #{computed_classes}"
  end

  def computed_classes
    "#{base_classes} #{size_class} #{@filled} #{@provided_classes}"
  end

  def base_classes
    "align-middle"
  end
end
