require "spec_helper"

describe TagsController do

  let(:valid_attributes) { FactoryGirl.attributes_for :tag }

  it "GET /tags/:id" do
    tag = double to_param: "123"
    allow(Tag).to receive(:find).with("123").and_return(tag)
    get :show, {:id => tag.to_param}
    expect(assigns(:tag)).to eq(tag)
  end

  describe "POST /books/:id/tags" do
    let(:book) { FactoryGirl.create :book }
    let(:tag) { FactoryGirl.create :tag, name: "Tag" }
    let(:tag_attrs) { { name: "Tag" } }

    describe "if the tag exists in the book tags" do
      before { book.add_tag tag }

      it "adds the tag to the book" do
        expect {
          post :create, { book_id: book.id, tag: tag_attrs, format: :js }
        }.to_not change { book.tags.count }
      end
    end

    describe "if the tag doenst exists in the book tags" do
      it "doenst add the tag to the book" do
        expect {
          post :create, { book_id: book.id, tag: tag_attrs, format: :js }
        }.to change { book.tags.count }.by(1)
      end
    end
  end

  describe "DELETE /tags/:id/books/:id" do
    let(:book) { FactoryGirl.create :book }
    let(:tag) { FactoryGirl.create :tag }

    before { book.add_tag tag }

    it "removes the tag form book tags" do
      expect {
        delete :destroy, { id: tag.id, book_id: book.id, format: :js }
      }.to change { book.tags.count }.by(-1)
    end
  end

end