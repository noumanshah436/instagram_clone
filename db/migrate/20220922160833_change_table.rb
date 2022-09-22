class ChangeTable < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :active, :boolean, default: true
    add_column :accounts, :active, :boolean, default: true
  end
end
