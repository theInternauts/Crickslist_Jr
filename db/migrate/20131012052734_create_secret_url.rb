class CreateSecretUrl < ActiveRecord::Migration
  def up
    create_table :secret_urls do |t|
      t.string :secret
      t.belongs_to :post
      t.timestamps
    end
  end

  def down
    drop_table :secret_urls
  end
end 
