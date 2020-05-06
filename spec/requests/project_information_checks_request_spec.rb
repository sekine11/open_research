require 'rails_helper'

RSpec.describe "ProjectInformationChecks", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/project_information_checks/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/project_information_checks/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
