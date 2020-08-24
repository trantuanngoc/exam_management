class CreateExams < ActiveRecord::Migration[6.0]
  def change
    create_table :exams do |t|
      t.string :name
      t.string :status
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
