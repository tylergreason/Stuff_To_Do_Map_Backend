class CreateAttractions < ActiveRecord::Migration[6.0]
  def change
    create_table :attractions do |t|
      t.string :name
      t.integer :user_id
      t.string :description
      t.float :lng
      t.float :lat
      t.integer :house_number
      t.string :road
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
