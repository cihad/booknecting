module BooksHelper

  def read_button book = @book
    classes = %w(small ui button)
    classes << "green" if current_user.books.exists? book

    button_to [:read, book], remote: true, form_class: "right floated", 
              method: :put, id: "#{dom_id book}", class: classes do
      I18n.t('users.books.read')
    end
  end
end
