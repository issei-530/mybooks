require 'rails_helper'

RSpec.describe "UserBooks", type: :request do

  describe "GET /destroy" do
    it "returns http success" do
      get "/user_books/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
