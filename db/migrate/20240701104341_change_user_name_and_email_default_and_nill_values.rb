class ChangeUserNameAndEmailDefaultAndNillValues < ActiveRecord::Migration[7.1]
  def change
    change_column_default(:users, :name, nil)
    change_column_null(:users, :name, true)

    change_column_default(:users, :email, nil)
  end
end
