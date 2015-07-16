class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :type_action
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
      t.integer :target_id
    end
  end
end
