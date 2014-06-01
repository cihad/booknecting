class AddAmazonAsinToBooks < ActiveRecord::Migration
  def change
    add_column :books, :amazon_asin, :string, index: true
  end
end
