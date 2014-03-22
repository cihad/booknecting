require "spec_helper"

describe UsersController do

  let(:valid_session) { {} }

  it "GET /users/:id" do
    user = double to_param: "123"
    allow(User).to receive(:find).with("123").and_return(user)

    get :show, {:id => user.to_param}, valid_session

    expect(assigns(:user)).to eq(user)
  end


end