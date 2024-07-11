class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :isbn_13, null: false
      t.decimal :list_price, null: false
      t.integer :publication_year, null: false
      t.string :image_url
      t.string :edition
      t.references :publisher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
