class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.references :actor, polymorphic: true, index: true
    end
  end
end
