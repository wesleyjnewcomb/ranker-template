class CreateContestants < ActiveRecord::Migration[5.1]
  def change
    create_table :contestants do |t|
      t.string :name, null: false
      t.string :img_url
      t.timestamps
    end
  end
end
