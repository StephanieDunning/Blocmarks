class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!

  def create
    @user = User.find_by(email: params[:sender])
    @topic = Topic.find_by(title: params[:subject])
    @url = params["body-plain"]

    if @user.nil?
      @user = User.new(
        email:                 params[:sender],
        password:              'helloworld',
        password_confirmation: params[:sender]
      )
      @user.save!
    end

    if @topic.nil?
      @topic = Topic.new
      @topic = @user.topics.create(title: params[:subject])
      @topic.save!
    end

    # @bookmark = Bookmark.new
    @bookmark = @topic.bookmarks.build(url: params['body-plain'])
    @bookmark.user = @user
    @bookmark.url = @url.strip
    @bookmark.save
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
