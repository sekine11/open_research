require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /hide" do
    it "returns http success" do
      get "/users/hide"
      expect(response).to have_http_status(:success)
    end
  end

end
