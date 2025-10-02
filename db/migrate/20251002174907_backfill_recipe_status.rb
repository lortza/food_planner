class BackfillRecipeStatus < ActiveRecord::Migration[7.2]
  # Migration AddStatusToRecipe sets default of status to 1 (active) for new records.
  # This migration changes the status for archived recipes based on their `archived` bool's value.
  #
  # After running this migration, the `archived` column can be removed in a future migration.
  #
  # Note: This migration assumes that the `status` column has already been added to the `recipes` table.
 
  def up
    Recipe.where(archived: true).update_all(status: 2)
  end

  def down
    Recipe.where(archived: true).update_all(status: 1)
  end
end
