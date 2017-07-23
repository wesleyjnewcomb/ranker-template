class CreateBallots < ActiveRecord::Migration[5.1]
  def change
    create_table :ballots do |t|
      t.belongs_to :contestant1, null: false
      t.belongs_to :contestant2, null: false
      t.integer :contestant1_wins, null: false, default: 0
      t.integer :contestant2_wins, null: false, default: 0

      t.timestamps
    end
  end
end
