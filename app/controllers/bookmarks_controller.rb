class BookmarksController < ApplicationController
  # before_action :set_bookmark, only: %i[new create]

  def new
    @list = List.find(params[:list_id])
    @movie = Movie.all
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:bookmark][:list_id])
    @movie = Movie.find(params[:bookmark][:movie_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    @bookmark.movie = @movie
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  # def set_bookmark
  #   @list = List.find(params[:list_id])
  # end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie, :list)
  end
end
