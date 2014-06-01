require "spec_helper"

describe BooksController do
  describe "routing" do

    it "routes to #index" do
      expect(get: 'books').to route_to(
        controller: 'books',
        action: 'index'
      )
    end

    it "routes to #new" do
      expect(get: 'books/new').to route_to(
        controller: 'books',
        action: 'new'
      )
    end

    it "routes to #edit" do
      expect(get: 'books/1/edit').to route_to(
        controller: 'books',
        action: 'edit',
        id: '1'
      )
    end

    it "routes to #create" do
      expect(post: 'books').to route_to(
        controller: 'books',
        action: 'create'
      )
    end

    it "routes to #update" do
      expect(put: 'books/1').to route_to(
        controller: 'books',
        action: 'update',
        id: '1'
      )
    end

    it "routes to #read" do
      expect(put: 'books/1/read').to route_to(
        controller: 'books',
        action: 'read',
        id: '1'
      )
    end

  end
end
