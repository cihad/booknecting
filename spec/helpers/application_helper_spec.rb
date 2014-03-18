require 'spec_helper'

describe ApplicationHelper do

  it "#title" do
    expect(helper.title(:h1, 'The Title')).to match /The Title/
    expect(helper.title { 'The Title' }).to match /The Title/
  end

  it "#page_title" do
    expect(helper.page_title('The Title')).to match /The Title/
    expect(helper.page_title { 'The Title' }).to match /The Title/
  end

  it "#sub_title" do
    expect(helper.sub_title('The Title')).to match /The Title/
    expect(helper.sub_title { 'The Title' }).to match /The Title/
  end

end