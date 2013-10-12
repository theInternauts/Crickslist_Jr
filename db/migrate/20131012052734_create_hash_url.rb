class CreateHashUrl < ActiveRecord::Migration
  def up
    create_table :hash_url do |t|
      t.string :hash
      t.belongs_to :post
      t.timestamps
    end
  end

  def down
    drop_table :hash_url
  end
end 
