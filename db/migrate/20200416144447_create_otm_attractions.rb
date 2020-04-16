class CreateOtmAttractions < ActiveRecord::Migration[6.0]
  def change
    create_table :otm_attractions do |t|

      t.timestamps
    end
  end
end
