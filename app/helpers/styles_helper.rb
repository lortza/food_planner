# frozen_string_literal: true

module StylesHelper
  def button_classes(style = 'info')
    "btn btn-sm btn-outline-#{style}"
  end

  def bootstrap_flash_class(type)
    modifier = case type
               when 'alert' || 'warning' then 'warning'
               when 'error' then 'danger'
               when 'success' then 'success'
               else
                 # ex: 'notice'
                 'info'
               end

    "alert alert-#{modifier} fadein mt-3"
  end
end
