class TracksController < ApplicationController

    before_action :require_log_in, only: [:show, :edit, :update, :destroy]

    def new
        @track = Track.new
        @album = Album.find_by(id: params[:album_id])
        render :new
    end

    def create
        @track = Track.new(track_params)
        if @track.save
            redirect_to track_url(@track)
        else
            flash.now[:errors] = @track.errors.full_messages
            @album = @track.album
            render :new
        end
    end

    def show
        @track = Track.find_by(id: params[:id])

        render :show
    end

    def destroy
        track = Track.find_by(id: params[:id])
        album = track.album
        track.destroy
        redirect_to album_url(album)
    end

    def edit
        @track = Track.find_by(id: params[:id])
        @album = @track.album 
        render :edit
    end

    def update
        @track = Track.find_by(id: params[:id])
        if @track.update(track_params)
            redirect_to track_url(@track)
        else
            flash.now[:errors] = @track.errors.full_messages
            @album = @track.album
            render :edit
        end
    end

    private
    def track_params
        params.require(:track).permit(:title, :album_id, :ord, :bonus_track, :lyrics)
    end
end
