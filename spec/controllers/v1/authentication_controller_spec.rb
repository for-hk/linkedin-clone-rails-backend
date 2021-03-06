require "rails_helper"

RSpec.describe V1::AuthenticationController, type: :controller do
  let(:valid_attributes) {
    {
      attributes: {
        name: "John Doe",
        email: "john@doe.com",
        password: "password",
      },
    }
  }

  let(:invalid_attributes) {
    {
      attributes: {
        email: "",
        password: "",
      },
    }
  }

  describe "#sign_up" do
    context "with valid params" do
      let(:mail) { UserMailer.welcome_email(User.last.id) }

      it "creates a new User" do
        post :sign_up, params: {data: valid_attributes}

        expect(User.count).to eq(1)
      end

      it "returns a valid token" do
        post :sign_up, params: {data: valid_attributes}

        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["auth_token"]).to eq("eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.5lZzU3qtpuwO46kszzvM9IwsADJS-iABVXwgphoqCpk")
      end

      it "sends a mail" do
        post :sign_up, params: {data: valid_attributes}

        expect(ActionMailer::Base.deliveries.count).to eq(3)
      end
    end

    context "with invalid params" do
      it "doesn't create a new User" do
        post :sign_up, params: {data: invalid_attributes}

        expect(User.count).to eq(0)
      end

      it "throws error" do
        post :sign_up, params: {data: invalid_attributes}

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq("{\"error\":{\"user_authentication\":[\"invalid credentials\"]}}")
      end
    end
  end

  describe "#sign_in" do
    context "with valid params" do
      it "returns a valid token" do
        user = User.create! valid_attributes

        post :sign_in, params: {data: valid_attributes}

        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["auth_token"]).to eq("eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0fQ.1CEFVHaaqOCggtDLJ-H1keNv4vK0Jb5VOOTiJeoanmk")
      end

      it "doesn't create a new User" do
        user = User.create! valid_attributes

        post :sign_in, params: {data: valid_attributes}

        expect(User.count).to eq(1)
      end
    end

    context "with invalid params" do
      it "throws error" do
        post :sign_in, params: {data: invalid_attributes}

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq("{\"error\":{\"user_authentication\":[\"invalid credentials\"]}}")
      end
    end
  end

  describe "#forgot_password" do
    let(:mail) { UserMailer.welcome_email(User.last.id) }

    it "sends a mail" do
      user = FactoryBot.create(:user, email: "john@doe.com", password: "some_unique_password")

      post :forgot_password, params: {data: valid_attributes}

      expect(ActionMailer::Base.deliveries.count).to eq(4)
    end

    it "resets the password of the user" do
      user = User.create! valid_attributes

      post :forgot_password, params: {data: {attributes: {
                               name: "John Doe",
                               email: "john@doe.com",
                               password: "some_new_password",
                             }}}

      post :sign_in, params: {data: valid_attributes}

      expect(response).to_not be_successful
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
