class AlbumsController < ApplicationController

    before_action :require_log_in, only: [:show, :edit, :update, :destroy]

    def new
        @band = Band.find_by(id: params[:band_id])
        @album = Album.new
        render :new
    end

    def create
        album = Album.new(album_params)

        if album.save
            redirect_to album_url(album)
        else
            #here we may consider using a flash in new to save the original band
            #and not the most recently selected band
            default_band = Band.find_by(id: params[:album][:band_id])
            redirect_to new_band_album_url(default_band)
        end
    end

    def show
        @album = Album.find_by(id: params[:id])
        render :show
    end

    def edit
        #not good form, but we (as in create) use @band to pass all the way into
        #our partial. Consider refactoring
        @album = Album.find_by(id: params[:id])
        @band = @album.band
        render :edit
    end

    def update
        album = Album.find_by(id: params[:id])

        if album.update(album_params)
            redirect_to album_url(album)
        else
            redirect_to album_url(album)
        end
    end

    def destroy
        album = Album.find_by(id: params[:id])
        band = album.band

        album.destroy
        redirect_to band_url(band)
    end

    private
    def album_params
        params.require(:album).permit(:title,:year,:band_id,:is_studio)
    end
end
