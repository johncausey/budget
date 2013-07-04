class AddFixedToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :fixed, :boolean, :default => false
  end
end
