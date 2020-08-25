class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :right_answer
      t.belongs_to :answer
      t.text :content

      t.timestamps
    end
  end
end
