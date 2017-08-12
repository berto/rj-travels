class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.text :article, null: false
      t.text :title, null: false
      t.text :name, null: false
      t.references :image, foreign_key: true
      t.date :date
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
