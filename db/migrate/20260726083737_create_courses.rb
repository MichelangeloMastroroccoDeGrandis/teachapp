class CreateCourses < ActiveRecord::Migration[8.1]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.text :description
      t.references :instructor, null: false, foreign_key: { to_table: :users }
      t.boolean :published, default: false, null: false
      t.decimal :price, precision: 8, scale: 2, default: 0.0
      t.timestamps
    end
  end
end
