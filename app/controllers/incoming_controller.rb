class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # @user = User.find_by(email: params[:sender])
    # @topic = Topic.find_by(title: params[:subject])
    # @bookmark = @topic.bookmarks.build(url: @url)
    # @bookmark.save
    puts "INCOMING PARAMS HERE: #{params}"
    head 200
  end
end

# You put the message-splitting and business
  # magic here.
   # Find the user by using params[:sender]
   # Find the topic by using params[:subject]
   # Assign the url to a variable after retreiving it from params["body-plain"]

   # Check if user is nil, if so, create and save a new user

   # Check if the topic is nil, if so, create and save a new topic

   # Now that you're sure you have a valid user and topic, build and save a new bookmark

  # Assuming all went well.