require 'spec_helper'

describe ApplicationHelper do

  it "#page_title" do
    expect(helper.page_title('The Title')).to match /The Title/
    expect(helper.page_title { 'The Title' }).to match /The Title/
  end

end