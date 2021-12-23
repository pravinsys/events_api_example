require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { User.create!(first_name: "first", last_name: "last", email: "abc@xyz.com", password: "password") }

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/users", headers: { "HTTP_API_USER_TOKEN": user.id }
      # expect(response.body).to eq('{"status":"online"}')
      expect(response.status).to eq(200)
    end
  end

end

