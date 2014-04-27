require 'spec_helper'

describe TagsController do

  it "routes to show" do
    expect(get: "tags/1").to route_to("tags#show", id: "1")
  end

  it "routes to create" do
    expect(post: "books/1/tags").to route_to("tags#create", book_id: "1")
  end

  it "routes to destory" do
    expect(delete: "books/1/tags/1").to route_to("tags#destroy", id: "1", book_id: "1")
  end

end