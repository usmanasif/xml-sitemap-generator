class CreateSitemaps < ActiveRecord::Migration[5.0]
  def change
    create_table :sitemaps do |t|
      t.string :url

      t.timestamps
    end
  end
end
