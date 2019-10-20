class AddExtraWorkNoteToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :extra_work_note, :string
  end
end
