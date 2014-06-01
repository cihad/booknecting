module BooksHelper

  def read_button book = @book
    if user_signed_in?
      classes = %w(small ui button)
      classes << "green" if current_user.read? book

      button_to [:read, book], remote: true, form_class: "right floated #{dom_id book}", 
                method: :put, class: classes do
        I18n.t('users.books.read')
      end
    end
  end
end
