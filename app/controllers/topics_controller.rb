class TopicsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_topic, except: [:index, :new, :create]

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new
    @topic.title = params[:topic][:title]

    if @topic.save
      flash[:notice] = "Topic was saved successfully."
      redirect_to @topic
    else
      flash.now[:alert] = "There was an error saving the topic. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.title = params[:topic][:title]

    if @topic.save
      flash[:notice] = "Topic was updated successfully."
      redirect_to @topic
    else
      flash.now[:alert] = "There was an error saving the topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.title}\" was deleted successfully."
      redirect_to topics_path
    else
      flash.now[:alert] = "There was an error deleting the topic."
      render :show
    end
  end

private
  def topic_params
    params.require(:topic).permit(:title, :private)
  end

  def find_topic
    @topic = Topic.find(params[:id])
  end
end
