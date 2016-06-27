class BookmarksController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_topic
  before_filter :find_bookmark, except: [:new, :create]

  def index
    @bookmarks = Bookmark.all
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params)
    @bookmark.user = current_user

    if @bookmark.save
      flash[:notice] = "Bookmark was saved."
      redirect_to @bookmark.topic
    else
      flash.now[:alert] = "There was an error saving the bookmark. Please try again."
      render :new
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.url = params[:bookmark][:url]

    if @bookmark.save
      flash[:notice] = "Bookmark was updated successfully."
      redirect_to @bookmark.topic
    else
      flash.now[:alert] = "There was an error updating the bookmark. Please try again."
      render :edit
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy
      flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully."
      redirect_to @bookmark.topic
    else
      flash.now[:alert] = "There was an error deleting the bookmark."
      render :show
    end
  end

private
  def bookmark_params
    params.require(:bookmark).permit(:url, :private)
  end

  def authorize_user
    @bookmark = Bookmark.find(params[:id])
    unless current_user == @bookmark.user
      flash[:alert] = "You must be the bookmark creator to do that."
      redirect_to @topic
    end
  end

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end

  def find_bookmark
    @bookmark = @topic.bookmarks.find(params[:id])
  end
end
