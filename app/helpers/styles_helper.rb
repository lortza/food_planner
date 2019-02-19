# frozen_string_literal: true

module StylesHelper
  def button_classes(style = 'primary')
    "btn btn-sm btn-#{style}"
  end
end
