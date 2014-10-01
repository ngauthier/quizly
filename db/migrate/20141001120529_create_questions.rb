class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :question,              null: false
      t.text :answer,                null: false
      t.column :distractors, 'text[]', null: false, default: []

      t.timestamps null: false
    end
  end
end
