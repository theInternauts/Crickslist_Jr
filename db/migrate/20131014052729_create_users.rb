class CreateUsers < ActiveRecord::Migration
  def up
  	create_table :users do |t|
  		t.string :email
  		t.string :password
      t.string :active, default: 'active'
  		t.timestamps
  	end

    add_column :posts, :user_id, :integer
    add_column :posts, :published, :string, default: 'published'
  end

  def down
  	drop_table :users
    remove_column :posts, :user_id
    remove_column :posts, :published
  end
end
