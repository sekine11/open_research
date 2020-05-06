require 'rails_helper'

RSpec.describe "Laboratories", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/laboratories/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/laboratories/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/laboratories/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/laboratories/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/laboratories/create"
      expect(response).to have_http_status(:success)
    end
  end

end
