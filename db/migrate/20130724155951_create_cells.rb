class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.string :sessionid
      t.string :cellstates

      t.timestamps
    end
  end
end
