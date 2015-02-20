class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.integer :site_num
      t.string :site_name
      t.string :telephone_num

      t.timestamps null: false
    end
  end
end
