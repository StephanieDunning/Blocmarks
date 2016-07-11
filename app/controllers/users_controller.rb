class UsersController < ApplicationController
  def show
    @user = current_user
    @topic = current_user.topics
    @liked_bookmarks = current_user.likes
    @user_bookmarks = current_user.bookmarks
  end
end
