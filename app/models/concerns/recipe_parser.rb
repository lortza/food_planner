class RecipeParser
  def initialize(source_file)
    @source_file = source_file
    user = User.find_by(admin: true)
    @recipe = Recipe.new(user_id: user.id)
    @reached_description = false
    @description_complete = false
    @reached_ingredients = false
    @reached_instructions = false
  end

  def parse_recipe
    IO.foreach(@source_file) do |line|
      parse_line(line)
    end
    p @recipe
    p @recipe.notes


  end

  def parse_line(line)
    # text = line.match('\:(.*)')
    key = line.split(':')[0]&.strip
    text = line.split(":").drop(1).join.strip

    @recipe.title = text if key == 'Title'

    if key == 'Description'
      @recipe.notes = ''
      @reached_description = true
    end
binding.pry
    if key != 'Source' && @reached_description == true && @description_complete == false
      @recipe.notes += " #{text}"
    end

    if key == 'Source'
      @description_complete = true

    end

    # case key
    # when 'Title'
    #   @recipe.title = text
    # when 'Description'
    #   @recipe.notes = text
    #   @reached_description = true
    # when 'Source'
    #   @recipe.source_name = text
    # when 'Original URL'
    #   @recipe.source_url = text
    # when 'Yield'
    #   @recipe.servings = text
    # when 'Active'
    #   number = extract_integer(text)
    #   @recipe.prep_time = number
    # when 'Total'
    #   number = extract_integer(text)
    #   @recipe.cook_time = number - @recipe.prep_time
    # when 'Image'
    #   @recipe.image_url = text
    # when 'Ingredients'
    #   @reached_ingredients = true
    #   puts 'handle ingredients here'
    # when 'Instructions'
    #   @reached_instructions = true
    #   @recipe.instructions = text
    #   puts 'handle instructions here'
    # else
    #   puts 'something else'
    # end # case
  end

  def set_description
  end

  def extract_integer(text)
    number = 0
    text.split(' ').each do |word|
      int = word.to_i
      number = int if int != 0
    end
  end
end
