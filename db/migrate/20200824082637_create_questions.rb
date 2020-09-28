class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :exam, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
