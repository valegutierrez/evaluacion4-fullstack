class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true
      t.boolean :done, default: false
      t.datetime :finished_at

      t.timestamps
    end
  end
end
