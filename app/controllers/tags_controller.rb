# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :set_tag, only: %i[show]

  # def index
  #   @tags = current_user.tags
  # end

  # def new
  #   @tag = current_user.tags.new
  # end

  # def create
  #   @tag = current_user.tags.new(tag_params)
  #   authorize(@tag)

  #   if @tag.save
  #     redirect_to tags_url
  #   else
  #     render :new
  #   end
  # end

  def show
    authorize(@tag)
  end

  # def edit
  #   # authorize(@tag)
  # end

  # def update
  #   # authorize(@tag)

  #   if @tag.update(tag_params)
  #     redirect_to tags_url
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   tag = Tag.find(params[:id])
  #   authorize(tag)

  #   tag.destroy
  #   flash[:success] = "tag deleted"
  #   redirect_to tags_path
  # end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:user_id, :recipe_id, :name)
  end
end
