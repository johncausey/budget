class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.decimal :amount, :precision => 8, :scale => 2
      t.datetime :date_added
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
