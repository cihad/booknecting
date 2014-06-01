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

  it "#amazon_book_path" do
    path = double
    obj = double
    allow(helper).to receive(:book_path).with(obj).and_return(path)
    expect(helper.amazon_book_path(obj)).to eql(path)
  end

  it "#amazon_book_tags_path" do
    path = double
    obj = double
    allow(helper).to receive(:book_tags_path).with(obj).and_return(path)
    expect(helper.amazon_book_tags_path(obj)).to eql(path)
  end

end