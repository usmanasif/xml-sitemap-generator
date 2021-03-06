class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :loc
      t.date :last_mod
      t.string :change_freq
      t.float :priority
      t.integer :parent_id
      t.integer :sitemap_id

      t.timestamps
    end
  end
end
