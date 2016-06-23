require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do

  let(:my_user) { create(:user) }
  let(:my_topic) { create(:topic, user: my_user) }
  let(:my_bookmark) { create(:bookmark, topic: my_topic) }

  describe "GET show" do
    it "returns http success" do
      get :show, topic_id: my_topic.id, id: my_bookmark.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, topic_id: my_topic.id, id: my_bookmark.id
      expect(response).to render_template :show
    end

    it "assigns my_bookmark to @bookmark" do
      get :show, topic_id: my_topic.id, id: my_bookmark.id
      expect(assigns(:bookmark)).to eq(my_bookmark)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, topic_id: my_topic.id
      expect(response).to render_template :new
    end

    it "instantiates @bookmark" do
      get :new, topic_id: my_topic.id
      expect(assigns(:bookmark)).not_to be_nil
    end
  end

  describe "BOOKMARK create" do
    it "increases the number of Bookmark by 1" do
      expect{bookmark :create, topic_id: my_topic.id, bookmark: {url: "new_url@example.com"}}.to change(Bookmark,:count).by(1)
    end

    it "assigns the new bookmark to @bookmark" do
      bookmark :create, topic_id: my_topic.id, bookmark: {url: "new_url@example.com"}
      expect(assigns(:bookmark)).to eq Bookmark.last
    end

    it "redirects to the new bookmark" do
      bookmark :create, topic_id: my_topic.id, bookmark: {url: "new_url@example.com"}
      expect(response).to redirect_to [my_topic, Bookmark.last]
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_bookmark.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, topic_id: my_topic.id, id: my_bookmark.id
      expect(response).to render_template :edit
    end

    it "assigns bookmark to be updated to @bookmark" do
      get :edit, topic_id: my_topic.id, id: my_bookmark.id
      bookmark_instance = assigns(:bookmark)

      expect(bookmark_instance.id).to eq my_bookmark.id
      expect(bookmark_instance.url).to eq my_bookmark.url
    end
  end

   describe "PUT update" do
     it "updates bookmark with expected attributes" do
       new_url = "new_url@example.com"

       put :update, topic_id: my_topic.id, id: my_bookmark.id, bookmark: {url: new_url}

       updated_bookmark = assigns(:bookmark)
       expect(updated_bookmark.id).to eq my_bookmark.id
       expect(updated_bookmark.url).to eq new_url
     end

     it "redirects to the updated bookmark" do
       new_url = "new_url@example.com"

      put :update, topic_id: my_topic.id, id: my_bookmark.id, bookmark: {url: new_url}
      expect(response).to redirect_to [my_topic, my_bookmark]
    end
  end

  describe "DELETE destroy" do
    it "deletes the bookmark" do
      delete :destroy, topic_id: my_topic.id, id: my_bookmark.id

      count = Bookmark.where({id: my_bookmark.id}).size
      expect(count).to eq 0
    end

    it "redirects to topic show" do
      delete :destroy, topic_id: my_topic.id, id: my_bookmark.id
      expect(response).to redirect_to my_topic
    end
  end
end
