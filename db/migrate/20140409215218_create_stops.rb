class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.string :number
      t.string :name
    end
  end
end
