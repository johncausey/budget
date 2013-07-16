class CreateSavings < ActiveRecord::Migration
  def change
    create_table :savings do |t|
      t.decimal :amount, :precision => 8, :scale => 2
      t.datetime :saving_month
      t.integer :user_id

      t.timestamps
    end
  end
end
