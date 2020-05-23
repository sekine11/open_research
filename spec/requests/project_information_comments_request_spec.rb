require 'rails_helper'

RSpec.describe "ProjectInformationComments", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/project_information_comments/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/project_information_comments/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/project_information_comments/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/project_information_comments/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/project_information_comments/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/project_information_comments/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/project_information_comments/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
