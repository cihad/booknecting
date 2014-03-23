class CreateJoinTableUserBook < ActiveRecord::Migration
  def change
    create_join_table :users, :books do |t|
      t.index [:user_id, :book_id], unique: true
      t.index [:book_id, :user_id], unique: true
    end
  end
end
