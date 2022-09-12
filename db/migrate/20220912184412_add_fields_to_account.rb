class AddFieldsToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :website, :string
    add_column :accounts, :bio, :text
  end
end
