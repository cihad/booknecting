require "spec_helper"

describe "Root" do
  it "routes to books#index" do
    expect(get: '/').to route_to("books#index")
  end
end