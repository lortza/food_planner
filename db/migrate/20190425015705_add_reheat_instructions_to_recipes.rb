class AddReheatInstructionsToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :reheat_instructions, :text, default: ''
  end
end
