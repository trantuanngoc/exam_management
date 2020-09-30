class CreateUserExams < ActiveRecord::Migration[6.0]
  def change
    create_table :user_exams do |t|
      t.belongs_to :user
      t.belongs_to :exam
      t.integer :score
      t.datetime :start_at
      t.datetime :end_at
      t.time :work_time
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
