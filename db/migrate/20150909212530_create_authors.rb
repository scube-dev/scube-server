class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.timestamps null: false

      t.string :name, null: false
    end
  end
end
