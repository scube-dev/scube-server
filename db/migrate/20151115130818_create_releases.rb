class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.timestamps null: false

      t.string :name, null: false
      t.integer :year, null: false
    end
  end
end
