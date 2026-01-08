class CreateNutritionProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :nutrition_profiles, id: :uuid, if_not_exists: true do |t|
      t.references :recipe, null: false, foreign_key: true, index: { unique: true }
      
      # Basic info
      t.integer :servings
      t.string :serving_size
      
      # Macronutrients
      t.decimal :calories, precision: 8, scale: 2
      t.decimal :protein_g, precision: 8, scale: 2
      t.decimal :fat_total_g, precision: 8, scale: 2
      t.decimal :fat_saturated_g, precision: 8, scale: 2
      t.decimal :fat_trans_g, precision: 8, scale: 2
      t.decimal :cholesterol_mg, precision: 8, scale: 2
      t.decimal :sodium_mg, precision: 8, scale: 2
      t.decimal :carbohydrates_total_g, precision: 8, scale: 2
      t.decimal :fiber_g, precision: 8, scale: 2
      t.decimal :sugar_g, precision: 8, scale: 2
      t.decimal :added_sugar_g, precision: 8, scale: 2
      
      # Micronutrients
      t.decimal :potassium_mg, precision: 8, scale: 2
      t.decimal :calcium_mg, precision: 8, scale: 2
      t.decimal :iron_mg, precision: 8, scale: 2
      t.decimal :vitamin_d_mcg, precision: 8, scale: 2
      
      # Metadata
      t.string :api_source
      t.jsonb :api_response_data
      t.datetime :last_calculated_at
      
      t.timestamps
    end
  end
end