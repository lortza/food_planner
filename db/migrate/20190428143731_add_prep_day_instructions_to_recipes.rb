class AddPrepDayInstructionsToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :prep_day_instructions, :text, default: ''
  end
end
