class CreateEnrollments < ActiveRecord::Migration[8.1]
  def change
    create_table :enrollments do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :course, null: false, foreign_key: true
      t.datetime :enrolled_at, default: -> { "CURRENT_TIMESTAMP" }
      t.integer :progress_percent, default: 0
      t.timestamps
    end
    add_index :enrollments, [ :student_id, :course_id ], unique: true
  end
end
