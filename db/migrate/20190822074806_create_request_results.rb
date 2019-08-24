class CreateRequestResults < ActiveRecord::Migration[6.0]
  def change
    create_table :request_results do |t|

      t.timestamps
    end
  end
end
