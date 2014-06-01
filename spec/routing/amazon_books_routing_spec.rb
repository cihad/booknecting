require "spec_helper"

describe AmazonBooksController do
  describe "routing" do
    it "routes to #read" do
      expect(put: 'amazon_books/ASIN123456/read').to route_to(
        controller: 'amazon_books',
        action: 'read',
        id: 'ASIN123456'
      )
    end
  end
end
