require 'spec_helper'

describe "rendering messages" do

  it "display the alert and the notice" do
    render 'application/messages', alert: "The Alert", notice: "The Notice"

    expect(rendered).to match('The Alert')
    expect(rendered).to match('The Notice')
  end

end