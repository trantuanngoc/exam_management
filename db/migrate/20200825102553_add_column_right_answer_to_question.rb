class AddColumnRightAnswerToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :right_answer, :bigint
  end
end
