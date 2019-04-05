class NotesController < ApplicationController

    def create
        note = Note.new(note_params)
        note.user_id = current_user.id 
        if note.save
            redirect_to track_url(note.track_id)
        else
            flash[:errors] = note.errors.full_messages
            redirect_to track_url(note.track_id)
        end
    end

    def destroy
        note = Note.find_by(id: paras[:id])
        track = note.track
        note.destroy
        redirect_to track_url(track)
    end

    private
    def note_params
        params.require(:note).permit(:text, :track_id)
    end
end
