class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :lesson, index: true, foreign_key: true
      t.integer :word_id
      t.integer :answer_id

      t.timestamps null: false
    end
    add_index :results, [:lesson_id, :created_at]
  end
end
