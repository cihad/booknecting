require 'spec_helper'

describe AmazonBooksController do

  let(:valid_session) { {} }
  let(:valid_attributes) { FactoryGirl.attributes_for :book }
  let(:invalid_attributes) { valid_attributes.merge(name: "") }
  let!(:book) { FactoryGirl.create :book }


  before do
    amazon_book = double :persist_from_amazon! => book
    allow(AmazonBook).to receive(:find).with("ASIN1234").and_return(amazon_book)
  end

  describe "PUT /books/:id/read" do
    let(:user) { FactoryGirl.create User }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "when user didnt read the book" do
      it "changes read? status from false to true" do
        expect {
          put :read, { id: "ASIN1234", format: :js }, valid_session
        }.to change { user.read? book }.from(false).to(true)
      end
    end

  end
end