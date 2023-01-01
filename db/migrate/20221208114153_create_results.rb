class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.integer :input
      t.text :output

      t.timestamps
    end
    add_index :results, :input, unique: true
  end

end
