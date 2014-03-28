require "spec_helper"

describe BooksHelper do

  describe "#read_button" do
    let(:user) { FactoryGirl.create :user } 
    let(:book) { FactoryGirl.create :book } 

    describe "when user didnt sign in" do
      it "returns nil" do
        allow(helper).to receive(:user_signed_in?).and_return(false)
        expect(helper.read_button(book)).to be_nil
      end
    end

    describe "when user signed in" do
      before do
        allow(helper).to receive(:user_signed_in?).and_return(true)
        allow(helper).to receive(:current_user).and_return(user)
      end

      it "when user didnt read the book" do
        expect(helper.read_button(book)).to have_selector 'button',
                                            text: I18n.t('users.books.read')
        expect(helper.read_button(book)).to_not have_selector '.green',
                                            text: I18n.t('users.books.read')
      end

      it "when user read the book" do
        user.read book
        expect(helper.read_button(book)).to have_selector '.green',
                                            text: I18n.t('users.books.read')
      end
    end
  end

end