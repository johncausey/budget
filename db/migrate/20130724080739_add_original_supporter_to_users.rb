class AddOriginalSupporterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :original_supporter, :boolean, :default => false
  end
end
