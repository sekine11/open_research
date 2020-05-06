require 'rails_helper'

RSpec.describe "LabMembers", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/lab_members/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/lab_members/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/lab_members/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/lab_members/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/lab_members/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
