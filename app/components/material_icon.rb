# frozen_string_literal: true

class MaterialIcon
  include ActionView::Helpers::TagHelper

  def initialize(icon:, title: nil, classes: nil)
    @icon = icon
    @title = title
    @classes = classes
  end

  def render
    case @icon
    when :arrow_left then arrow_left;
    when :calendar_clock then calendar_clock;
    when :clock then clock;
    when :edit then edit_note;
    when :new then new_release;
    when :plus_circle then plus_circle;
    when :plus_square then plus_square;
    when :star_filled then star_filled;
    when :star_outline then star_outline;
    when :sync then sync;
    when :trash then trash;
    else
      raise 'ERROR: Available icons are :arrow_left, :calendar_clock, :clock, :edit, :new, :plus_circle, :plus_square, :star_filled, :star_outline, :sync, :trash'
    end
  end

  private

  def arrow_left
    content_tag(:span, 'arrow_back',
      class: "#{symbol_base_classes} #{@classes} nav-link-icon left",
      title: @title.presence || 'Back')
  end

  def calendar_clock
    content_tag(:span, 'calendar_clock',
      class: "#{symbol_base_classes} #{@classes} text-warning",
      title: @title.presence || "It's been a while")
  end

  def clock
    content_tag(:span, 'update',
      class: symbol_base_classes,
      title: @title.presence || 'Duration warning')
  end

  def edit_note
    content_tag(:span, 'edit_note',
      class: "#{symbol_base_classes} #{@classes} float-right",
      title: @title.presence || 'Edit')
  end

  def new_release
    content_tag(:span, 'new_releases',
      class: "#{symbol_base_classes} #{@classes} text-warning",
      title: @title || 'New')
  end

  def plus_circle
    content_tag(:span, 'add_circle',
      class: "#{symbol_base_classes} #{@classes}",
      title: @title.presence || 'Add')
  end

  def plus_square
    content_tag(:span, 'add_box',
      class: "#{symbol_base_classes} #{@classes}",
      title: @title.presence || 'Add to list')
  end

  def star_filled
    content_tag(:span, 'star',
      class: "#{icon_base_classes} #{@classes} text-warning",
      title: @title.presence || 'Starred')
  end

  def star_outline
    content_tag(:span, 'star',
      class: "#{symbol_base_classes} #{@classes}",
      title: @title.presence || 'Star')
  end

  def sync
    content_tag(:span, 'sync',
      class: "#{symbol_base_classes} #{@classes} nav-link-icon",
      title: @title.presence || 'Sync')
  end

  def trash
    content_tag(:span, 'delete',
      class: "#{symbol_base_classes} #{@classes}",
      title: @title.presence || 'Delete')
  end

  def symbol_base_classes
    "material-symbols-outlined"
  end

  def icon_base_classes
    "material-icons-outlined"
  end
end