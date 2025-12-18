class NotesController < ApplicationController
  before_action :set_note, only: %i[show edit update destroy]

  # GET /notes
  def index
    @notes = current_user.notes.all
  end

  # GET /notes/1
  def show
  end

  # GET /notes/new
  def new
    @note = current_user.notes.new
  end

  # GET /notes/1/edit
  def edit
    authorize(@note)
  end

  # POST /notes
  def create
    @note = current_user.notes.new(note_params)
    authorize(@note)

    if @note.save
      redirect_to @note, notice: "Note was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  def update
    authorize(@note)

    if @note.update(note_params)
      redirect_to @note, notice: "Note was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  def destroy
    authorize(@note)

    @note.destroy!
    redirect_to notes_path, notice: "Note was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = current_user.notes.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def note_params
    params.require(:note).permit(:user_id, :title, :content, :favorite)
  end
end
