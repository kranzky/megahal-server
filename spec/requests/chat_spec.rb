require 'rails_helper'

RSpec.describe "Chats", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/chat/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /say" do
    it "returns http success" do
      get "/chat/say"
      expect(response).to have_http_status(:success)
    end
  end

end
