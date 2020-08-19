class AddBoardReferenceToMessage < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :board, foreign_key: true
  end
end
