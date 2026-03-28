# Commenting out this migration since it was only needed for backfilling data and is no longer necessary. 

# class BackfillLastPreparedOnRecipeData < ActiveRecord::Migration[8.1]
#   def up
#     say_with_time "Backfilling last_prepared_on for recipes" do
#       Recipe.find_each do |recipe|
#         last_prepared_on = recipe.meal_plans.maximum(:prepared_on)
#         recipe.update_column(:last_prepared_on, last_prepared_on) unless last_prepared_on.nil?
#       end
#     end
#   end

#   def down
#     say_with_time "Removing last_prepared_on from recipes" do
#       Recipe.update_all(last_prepared_on: nil)
#     end
#   end
# end
