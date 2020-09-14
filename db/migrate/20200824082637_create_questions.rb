class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :right_answer
      t.text :content

      t.timestamps
    end
  end
end
