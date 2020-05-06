require 'rails_helper'

RSpec.describe "LabInformationComments", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/lab_information_comments/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/lab_information_comments/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
