class CreateSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
