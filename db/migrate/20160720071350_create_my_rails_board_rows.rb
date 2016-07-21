class CreateMyRailsBoardRows < ActiveRecord::Migration
  def change
    create_table :my_rails_board_rows do |t|
      t.string :subject
      t.string :name
      t.string :mail
      t.string :memo
      t.integer :hits

      t.timestamps null: false
    end
  end
end
