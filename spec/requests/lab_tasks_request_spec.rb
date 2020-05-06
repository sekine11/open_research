require 'rails_helper'

RSpec.describe "LabTasks", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/lab_tasks/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/lab_tasks/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/lab_tasks/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
