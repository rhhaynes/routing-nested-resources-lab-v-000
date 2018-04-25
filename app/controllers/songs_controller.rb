class SongsController < ApplicationController
  before_action :set_artist, only: [:index, :show]
  
  def index
    if !!params[:artist_id]
      if !!@artist then @songs = @artist.songs
      else redirect_to artists_path, notice: "Artist not found."
      end
    else
      @songs = Song.all
    end
  end

  def show
    if !!params[:artist_id]
      if !!( @song = Song.find_by(:id => params[:id], :artist_id => params[:artist_id]) ) then @song
      else redirect_to artist_songs_path(@artist), alert: "Song not found."
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private
  
  def set_artist
    ( @artist = Artist.find_by(:id => params[:artist_id]) ) if !!params[:artist_id]
  end

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

