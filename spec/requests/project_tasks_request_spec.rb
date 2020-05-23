require 'rails_helper'

RSpec.describe "ProjectTasks", type: :request do

  describe "GET /update" do
    it "returns http success" do
      get "/project_tasks/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/project_tasks/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/project_tasks/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
