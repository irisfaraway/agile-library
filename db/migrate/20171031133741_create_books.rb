class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.integer :status
      t.string :title
      t.string :author
      t.string :location

      t.timestamps
    end
  end
end
