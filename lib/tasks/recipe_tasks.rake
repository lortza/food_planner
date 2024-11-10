# frozen_string_literal: true

namespace :recipes do
  desc "Backfill prep_day_instructions"
  task backfill_prep_day_instructions: :environment do
    ActiveRecord::Base.transaction do
      puts 'Backfilling all prep_day_instructions with instructions values'
      # There are 218 Records in production, so the poor perfomance of this each loop is not an issue.
      Recipe.all.each do |recipe|
        next if recipe.prep_day_instructions.blank? && recipe.instructions.blank?
        next if recipe.prep_day_instructions.present? && recipe.instructions.present?

        recipe.update!(prep_day_instructions: recipe.instructions) if recipe.prep_day_instructions.blank?
        recipe.update!(instructions: recipe.prep_day_instructions) if recipe.instructions.blank?
      end
    end
  end
end