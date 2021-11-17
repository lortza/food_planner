# frozen_string_literal: true

class Recipe < ApplicationRecord
  extend Searchable

  attr_accessor :experimental_recipe_id

  belongs_to :user
  has_many :ingredients, inverse_of: :recipe, dependent: :destroy
  accepts_nested_attributes_for :ingredients,
                                reject_if: :all_blank, # at least 1 ingredient should be present
                                allow_destroy: true # allows user to delete ingredient via checkbox
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :meal_plans, through: :meal_plan_recipes

  DEFAULT_SOURCE = { source_name: 'Original Creation', source_url: '/' }.freeze
  DEFAULT_PARAMS = {
    prep_time: 10,
    cook_time: 20,
    servings: 2
  }.freeze

  before_validation :provide_default_source, on: :create
  # before_save :instructions_to_lines

  validates :title,
            :servings,
            :instructions,
            :source_name,
            :source_url,
            :prep_time,
            :cook_time,
            :reheat_time,
            presence: true

  validates :prep_time, numericality: { other_than: 0 }, if: -> { cook_time&.zero? && reheat_time&.zero? }
  validates :cook_time, numericality: { other_than: 0 }, if: -> { reheat_time&.zero? && prep_time&.zero? }
  validates :reheat_time, numericality: { other_than: 0 }, if: -> { prep_time&.zero? && cook_time&.zero? }


  def self.cool_search(search_terms = '')
    # In PostgreSQL Speak...
    # SELECT DISTINCT r.title, r.source_url, r.source_name
    # FROM recipes r
    # LEFT JOIN ingredients i on i.recipe_id = r.id
    # WHERE concat_ws(' ', r.title, r.source_name, r.extra_work_note) ILIKE '%rice%'
    # OR i.name ILIKE '%rice%'
    # ;

    # In ActiveRecord Speak...
    stripped_terms = search_terms&.gsub(',', '')&.squish
    concat_statement = "concat_ws(' ', recipes.title, recipes.source_url, recipes.source_name) ILIKE ?"

    left_outer_joins(:ingredients)
      .where(concat_statement, "%#{stripped_terms}%")
      .or(
        Ingredient.where('ingredients.name ILIKE ?', "%#{stripped_terms}%")
      )
      .distinct
  end


  # Where I left off...
  # I'm trying to come up with an example of how to do this heredoc version of a sql query
  # but i am having trouble with the :v_search_terms being read like '%':v_search_terms'%'
  # instead of '%:v_search_terms%' 
  def self.cool_search_w_sql(search_terms = '')
    stripped_terms = search_terms&.gsub(',', '')&.squish


    # Example of conditional SQL: Use ruby to make a line of SQL that's conditional and set it to a variable. We'll interpolate it below.
    # sql_bin = 'AND bp.bin = :v_bin' if bin.present?
    # sql_pcn = 'AND bp.pcn = :v_pcn' if pcn.present?

    query = <<~SQL
      SELECT DISTINCT r.title, r.source_url, r.source_name
      FROM recipes r
      LEFT JOIN ingredients i on i.recipe_id = r.id
      WHERE concat_ws(' ', r.title, r.source_name, r.extra_work_note) ILIKE '%:v_search_terms%'
      OR i.name ILIKE '%:v_search_terms%'
      ORDER BY r.title
      ;
    SQL

    # SELECT * FROM puf_plan_information pi
    #   -- This `:v_search_terms` syntax with the colon is coming from the sanitized params.
    #   -- I'm using the `v_` to help disambiguate these sanitized params from the args coming in the
    #   -- top of the method.
    #   WHERE pi.file_name = :v_file_name
    #    AND pi.state = :v_state
    #    AND pi.premium IS NOT NULL
    #    AND pi.plan_id IS NOT NULL
    #   -- If you have simple sql and no outside value being passed in, it is safe to
    #   -- straight interpolate the sql into this string like so:
    #    #{sql_bin}
    #    #{sql_pcn}
    #   -- In our case, we needed to use a sanitized version (up at the top) of the sql before interpolating it.
    #  ORDER BY pi.plan_name

    # We're about to sanitize these params below...
    query_params = {
      v_search_terms: stripped_terms
    }
    ActiveRecord::Base.connection.execute(
      # ...and this is where they get sanitized.
      ActiveRecord::Base.sanitize_sql_for_conditions([query, query_params]),
    ).to_a
  end


  def self.by_last_prepared
    order('meal_plans.prepared_on asc')
  end

  def self.active
    where(archived: false)
  end

  def active?
    archived == false
  end

  def frequency
    meal_plans.count
  end

  def provide_default_source
    self.source_name = DEFAULT_SOURCE[:source_name] if source_name.blank?
    self.source_url = DEFAULT_SOURCE[:source_url] if source_url.blank?
  end

  def checkbox_label
    output = "#{title} (#{servings} servings)"
    last_prepared ? output + ": #{last_prepared}" : output
  end

  def last_prepared
    meal_plans.pluck(:prepared_on).max
  end

  def total_time
    prep_time + cook_time
  end

  def instructions_to_lines
    self.instructions = instructions.tr("\r", "\n")
  end

  def extra_work_required?
    extra_work_note.present?
  end

  def dupe_for_user(user)
    original_ingredients = ingredients
    copied_recipe = dup
    copied_recipe.update(user_id: user.id)
    original_ingredients.each do |ingredient|
      copied_ingredient = ingredient.dup
      copied_recipe.ingredients << copied_ingredient
    end
  end
end
