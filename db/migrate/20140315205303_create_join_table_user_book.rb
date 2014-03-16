class CreateJoinTableUserBook < ActiveRecord::Migration
  def change
    create_join_table :users, :books do |t|
      t.index [:user_id, :book_id]
      t.index [:book_id, :user_id]
    end
  end
end
