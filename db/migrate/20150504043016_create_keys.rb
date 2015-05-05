class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.timestamps null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.string :name
      t.string :token
    end

    add_index :keys, :token, unique: true
  end
end
