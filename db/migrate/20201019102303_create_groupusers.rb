class CreateGroupusers < ActiveRecord::Migration[6.0]
  def change
    create_table :groupusers do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
