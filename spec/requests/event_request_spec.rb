require 'rails_helper'

RSpec.describe "Events", type: :request do
  let!(:user) { User.create!(first_name: "first", last_name: "last", email: "abc@xyz.com", password: "password") }

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/events", headers: { "HTTP_API_USER_TOKEN": user.id }
      expect(response.status).to eq(200)
    end
  end

  describe "GET /show" do
    let!(:event) { Event.create!(name: "Event test 1") }
    it "returns http success" do
      get "/api/v1/events/#{event.id}", headers: { "HTTP_API_USER_TOKEN": user.id }
      expect(response.body).to include("Event test 1")
      expect(response.status).to eq(200)
    end
  end

  describe "POST /events" do
    let!(:event) { Event.create!(name: "Event test 1") }
    it "create new event" do
      post "/api/v1/events", params: { event: { name: "Event test 2" }}, headers: { "HTTP_API_USER_TOKEN": user.id }
      expect(response.body).to include("Event test 2")
      expect(response.status).to eq(201)

      get "/api/v1/events", headers: { "HTTP_API_USER_TOKEN": user.id }
      expect(response.status).to eq(200)
      expect(response.body).to include("Event test 1")
      expect(response.body).to include("Event test 2")
    end
  end

  describe "PUT /events" do
    let!(:event) { Event.create!(name: "Event test 1") }
    it "Update existing event" do
      put "/api/v1/events/#{event.id}", params: { event: { name: "Event test was updated" }}, headers: { "HTTP_API_USER_TOKEN": user.id }
      expect(response.body).to include("Event test was updated")
      expect(response.status).to eq(201)

      get "/api/v1/events", headers: { "HTTP_API_USER_TOKEN": user.id }
      expect(response.status).to eq(200)
      expect(response.body).not_to include("Event test 1")
    end
  end

  describe "Get /register" do
    let!(:event) { Event.create!(name: "Event test 1") }
    it "Register to event" do
      get "/api/v1/events", headers: { "HTTP_API_USER_TOKEN": user.id }
      expect(response.status).to eq(200)
      expect(response.body).not_to include(user.first_name)

      get "/api/v1/events/#{event.id}/register", headers: { "HTTP_API_USER_TOKEN": user.id }
      expect(response.body).to include(user.first_name)
    end
  end
end

