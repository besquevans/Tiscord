class AddAvatarToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :avatar, :string
  end
end
