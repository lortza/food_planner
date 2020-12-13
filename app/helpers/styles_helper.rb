# frozen_string_literal: true

module StylesHelper
  def button_classes(style = 'info')
    "btn btn-sm btn-outline-#{style}"
  end

  def bootstrap_flash_class(type)
    modifier = case type
               when 'alert' then 'warning'
               when 'error' then 'danger'
               when 'warning' then 'warning'
               when 'notice' then 'info'
               when 'success' then 'success'
               else
                 'info'
               end

    "alert alert-#{modifier} fadein mt-3"
  end
end
