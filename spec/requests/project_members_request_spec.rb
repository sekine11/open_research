require 'rails_helper'

RSpec.describe "ProjectMembers", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/project_members/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/project_members/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/project_members/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/project_members/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/project_members/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
