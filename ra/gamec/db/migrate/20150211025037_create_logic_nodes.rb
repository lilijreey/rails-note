class CreateLogicNodes < ActiveRecord::Migration
  def change
    create_table :logic_nodes do |t|
      t.string :name
      t.string :ip
      t.integer :status
      t.timestamps :online_at

      t.timestamps
    end
  end
end
