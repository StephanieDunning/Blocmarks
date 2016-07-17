class UsersController < ApplicationController
  def show
    @user = current_user
    @topic = current_user.topics
    @grouped_liked_bookmarks = current_user.likes.group_by{|like| like.bookmark.topic}
    @grouped_user_bookmarks = current_user.bookmarks.group_by(&:topic)
  end
end
