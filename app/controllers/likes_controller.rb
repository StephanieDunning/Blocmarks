class LikesController < ApplicationController

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @like = current_user.likes.build(bookmark: @bookmark)
    authorize @like

    if @like.save
      flash[:notice] = "Bookmark liked"
      redirect_to [@bookmark.topic, @bookmark]
    else
      flash.now[:alert] = "Failed to like Bookmark"
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    @like = current_user.likes.find_by(bookmark: @bookmark)

    if @like.destroy
      flash[:notice] = "Bookmark unliked"
      redirect_to [@bookmark.topic, @bookmark]
    else
      flash[:alert] = "Failed to unlike Bookmark"
      render :show
    end
  end
end
