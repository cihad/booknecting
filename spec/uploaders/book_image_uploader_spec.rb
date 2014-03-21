require 'spec_helper'
require 'carrierwave/test/matchers'

describe BookImageUploader do
  include CarrierWave::Test::Matchers

  let(:book) { stub_model Book }
  let(:uploader) { BookImageUploader.new(book, :image) }

  before do
    BookImageUploader.enable_processing = true
    uploader.store!(File.open(Rails.root.join('spec/support/images/01.png')))
  end

  after do
    BookImageUploader.enable_processing = false
    uploader.remove!
  end

  context 'the medium version' do
    it "scales down a landscape image to be fixed width by 260" do
      expect(uploader.medium).to be_no_larger_than(260, 260)
    end
  end

end