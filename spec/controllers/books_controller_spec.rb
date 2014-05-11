require 'spec_helper'

describe BooksController do
  
  let(:valid_session) { {} }
  let(:valid_attributes) { FactoryGirl.attributes_for :book }
  let(:invalid_attributes) { valid_attributes.merge(name: "") }
  let!(:book) { FactoryGirl.create :book }

  describe "GET /books" do

    it "params search exists" do
      books = double
      allow(Book).to receive(:search).with('sample').and_return(books)

      get :index, { search: 'sample' }, valid_session

      expect(assigns(:books)).to eq(books)
    end

    it "params search doesnt exist" do
      books = double
      allow(Book).to receive(:top).with(count: 10).and_return(books)

      get :index, { }, valid_session
      
      expect(assigns(:books)).to eq(books)
    end

    
  end

  it "GET /books/:id" do
    book = double to_param: "123"
    allow(Book).to receive(:find).with("123").and_return(book)

    get :show, {:id => book.to_param}, valid_session

    expect(assigns(:book)).to eq(book)
  end

  it "GET /books/new" do
    book = double
    allow(Book).to receive(:new).and_return(book)

    get :new, {}, valid_session

    expect(assigns(:book)).to eq(book)
  end

  it "GET /books/:id/edit" do
    book = double to_param: "123"
    allow(Book).to receive(:find).with("123").and_return(book)

    get :edit, { id: "123" }, valid_session

    expect(assigns(:book)).to eq(book)
  end

  describe "POST /books" do
    describe "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, {:book => valid_attributes}, valid_session
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created book as @book" do
        post :create, {:book => valid_attributes}, valid_session
        expect(assigns(:book)).to be_a(Book)
        expect(assigns(:book)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved book as @book" do
        allow_any_instance_of(Book).to receive(:save).and_return(false)
        post :create, {:book => { "name" => "" }}, valid_session
        expect(assigns(:book)).to be_a_new(Book)
      end

      it "re-renders the 'new' template" do
        allow_any_instance_of(Book).to receive(:save).and_return(false)
        post :create, {:book => { "name" => "" }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT /books" do
    describe "with valid params" do
      it "updates the requested book" do
        attrs = valid_attributes
        put :update, {:id => book.to_param, :book => attrs}, valid_session
        expect(book.reload.name).to eq(attrs[:name])
      end

      it "assigns the requested book as @book" do
        put :update, {:id => book.to_param, :book => valid_attributes}, valid_session
        expect(assigns(:book)).to eq(book)
      end
    end

    describe "with invalid params" do
      it "assigns the book as @book" do
        put :update, {:id => book.to_param, :book => invalid_attributes}, valid_session
        expect(assigns(:book)).to eq(book)
      end

      it "re-renders the 'edit' template" do
        allow_any_instance_of(Book).to receive(:update).and_return(false)
        allow(controller).to receive(:book_params)
        put :update, {:id => book.to_param }, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "PUT /books/:id/read" do
    let(:user) { FactoryGirl.create User }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "when user didnt read the book" do
      it "changes read? status from false to true" do
        expect {
          put :read, { id: book.to_param, format: :js }, valid_session
        }.to change { user.read? book }.from(false).to(true)
      end
    end

    describe "when user read the book" do
      it "changes read? status from true to false" do
        user.read book

        expect {
          put :read, { id: book.to_param, format: :js }, valid_session
        }.to change { user.read? book }.from(true).to(false)
      end
    end
  end
end