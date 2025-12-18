# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Notes", type: :request do
  let!(:user) { create(:user) }
  let!(:note) { create(:note, user: user) }

  describe "Public access to notes" do
    describe "GET /notes" do
      it "denies access to notes#index" do
        get notes_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "GET /notes/:id" do
      it "denies access to notes#show" do
        get note_path(note)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end

    it "denies access to notes#new" do
      get new_note_path
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to notes#edit" do
      get edit_note_path(note)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to notes#create" do
      note_attributes = attributes_for(:note)

      expect {
        post notes_path, params: {note: note_attributes}
      }.to_not change(Note, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to notes#update" do
      patch note_path(note), params: {note: {title: "Updated Title"}}
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to notes#destroy" do
      delete note_path(note)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Authenticated access to own notes" do
    before :each do
      sign_in user
    end

    describe "GET /notes" do
      it "renders notes#index" do
        get notes_path

        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /notes/:id" do
      it "renders notes#show" do
        get note_path(note)

        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /notes/new" do
      it "renders notes#new" do
        get new_note_path

        expect(response).to be_successful
        expect(response).to render_template(:new)
      end
    end

    describe "GET /notes/:id/edit" do
      it "renders notes#edit" do
        get edit_note_path(note)

        expect(response).to be_successful
        expect(response).to render_template(:edit)
        expect(response.body).to include(note.title)
      end
    end

    describe "POST /notes" do
      context "with valid parameters" do
        let(:valid_attributes) { attributes_for(:note, title: "New Note", content: "Note content") }

        it "creates a new Note" do
          expect {
            post notes_path, params: {note: valid_attributes}
          }.to change(Note, :count).by(1)
        end

        it "redirects to the created note" do
          post notes_path, params: {note: valid_attributes}
          created_note = user.notes.order(created_at: :desc).first
          expect(response).to redirect_to(note_path(created_note))
        end
      end

      context "with invalid parameters" do
        let(:invalid_attributes) { attributes_for(:note, title: "", content: "") }

        it "does not create a new Note" do
          expect {
            post notes_path, params: {note: invalid_attributes}
          }.to_not change(Note, :count)
        end

        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          post notes_path, params: {note: invalid_attributes}
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "PATCH /notes/:id" do
      context "with valid parameters" do
        let(:new_attributes) { {title: "Updated Title", content: "Updated content"} }

        it "updates the requested note" do
          patch note_path(note), params: {note: new_attributes}
          note.reload

          expect(note.title).to eq("Updated Title")
          expect(note.content).to eq("Updated content")
        end

        it "redirects to the note" do
          patch note_path(note), params: {note: new_attributes}
          note.reload

          expect(response).to redirect_to(note_path(note))
        end
      end

      context "with invalid parameters" do
        let(:invalid_attributes) { {title: "", content: ""} }

        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          patch note_path(note), params: {note: invalid_attributes}
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "DELETE /notes/:id" do
      it "destroys the requested note" do
        note_to_delete = create(:note, user: user)

        expect {
          delete note_path(note_to_delete)
        }.to change(Note, :count).by(-1)
      end

      it "redirects to the notes list" do
        delete note_path(note)
        expect(response).to redirect_to(notes_path)
      end
    end
  end

  describe "Authenticated access to other users' notes" do
    let!(:other_user) { create(:user) }
    let!(:other_note) { create(:note, user: other_user) }

    before :each do
      sign_in user
    end

    it "denies access to notes#show for other user's note" do
      get note_path(other_note)
      expect(response).to redirect_to(root_path)
    end

    it "denies access to notes#edit for other user's note" do
      get edit_note_path(other_note)
      expect(response).to redirect_to(root_path)
    end

    it "denies access to notes#update for other user's note" do
      patch note_path(other_note), params: {note: {title: "Hacked"}}
      expect(response).to redirect_to(root_path)
    end

    it "denies access to notes#destroy for other user's note" do
      delete note_path(other_note)
      expect(response).to redirect_to(root_path)
    end
  end
end
