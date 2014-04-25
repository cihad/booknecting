require "spec_helper"

describe TagsController do

  let(:valid_attributes) { FactoryGirl.attributes_for :tag }

  it "GET /tags/:id" do
    tag = double to_param: "123"
    allow(Tag).to receive(:find).with("123").and_return(tag)
    get :show, {:id => tag.to_param}
    expect(assigns(:tag)).to eq(tag)
  end

  describe "POST /books" do
    describe "with valid params" do
      it "creates a new tag" do
        expect {
          post :create, { tag: valid_attributes, format: :js }
        }.to change(Tag, :count).by(1)
      end
    end

    describe "with invalid params" do
      it "doesnt create a tag" do
        expect {
          post :create, { tag: valid_attributes.merge(name: ""), format: :js }
        }.to_not change(Tag, :count)
      end
    end
  end



end