require 'spec_helper'

describe "rendering messages" do

  before do
    render 'application/header'
  end

  it "display the alert and the notice" do
    expect(rendered).to have_selector 'a', text: 'Booknecting'
  end

end