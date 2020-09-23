class CreateTakeAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :take_answers do |t|
      t.belongs_to :user_exam
      t.belongs_to :answer
      t.belongs_to :question

      t.timestamps
    end
  end
end
