class AddBoardIdToGroup < ActiveRecord::Migration[6.0]
  def change
    add_reference :boards, :group, foreign_key: true
  end
end
