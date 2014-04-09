class CreateRouteDirections < ActiveRecord::Migration
  def change
    create_table :route_directions do |t|
      t.integer :route_id
      t.integer :direction_id

      t.timestamps
    end
  end
end
