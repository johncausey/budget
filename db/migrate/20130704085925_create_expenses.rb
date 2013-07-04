class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.decimal :amount, :precision => 8, :scale => 2
      t.datetime :date_added
      t.integer :user_id

      t.timestamps
    end
  end
end
