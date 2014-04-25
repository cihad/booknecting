require 'spec_helper'

describe TagsController do

  it "routes to show" do
    expect(get: "tags/1").to route_to("tags#show", id: "1")
  end

  it "routes to create" do
     expect(post: "tags").to route_to("tags#create")
  end

end