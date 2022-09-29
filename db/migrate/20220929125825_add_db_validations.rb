class AddDbValidations < ActiveRecord::Migration[5.2]
  def change
    change_column_null :comments, :post_id, false
    change_column_null :comments, :account_id, false

    change_column_null :likes, :post_id, false
    change_column_null :likes, :account_id, false

    change_column_null :follows, :follower_id, false
    change_column_null :follows, :followee_id, false

    change_column_null :photos, :post_id, false

    change_column_null :posts, :account_id, false

    change_column_null :stories, :account_id, false
  end
end
