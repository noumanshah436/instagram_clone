class AddImageValidations < ActiveRecord::Migration[5.2]
  def change
    change_column_null :stories, :image, false
    change_column_null :photos, :image, false
  end
end
