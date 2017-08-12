class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :title, null: false
      t.string :link, null: false
      t.integer :country_code

      t.timestamps
    end
  end
end
