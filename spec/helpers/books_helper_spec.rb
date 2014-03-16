require "spec_helper"

describe BooksHelper do

  describe "#read_button" do
    let(:user) { FactoryGirl.create :user } 
    let(:book) { FactoryGirl.create :book } 

    before do
      allow(helper).to receive(:current_user).and_return(user)
    end

    it "when user didnt read the book" do
      expect(helper.read_button(book)).to have_selector 'button',
                                          text: I18n.t('users.books.read')
      expect(helper.read_button(book)).to_not have_selector '.green',
                                          text: I18n.t('users.books.read')
    end

    it "when user read the book" do
      user.books << book
      expect(helper.read_button(book)).to have_selector '.green',
                                          text: I18n.t('users.books.read')
    end
  end

end