class CreateExamQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :exam_questions do |t|
      t.belongs_to :question
      t.belongs_to :exam

      t.timestamps
    end
  end
end
