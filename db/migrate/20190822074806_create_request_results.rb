class CreateRequestResults < ActiveRecord::Migration[6.0]
  def change
    create_table :request_results do |t|
      t.text :raw_data, null: false
      t.text :parsed_data
      t.timestamps
    end
  end
end
