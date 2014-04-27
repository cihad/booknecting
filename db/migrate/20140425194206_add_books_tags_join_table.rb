class AddBooksTagsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :books, :tags do |t|
      t.index [:book_id, :tag_id], unique: true
    end
  end
end
