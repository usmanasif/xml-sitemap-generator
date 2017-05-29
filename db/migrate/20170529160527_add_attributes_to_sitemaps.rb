class AddAttributesToSitemaps < ActiveRecord::Migration[5.0]
  def change
    add_column :sitemaps, :status, :string
    add_column :sitemaps, :crawl_operation_count, :integer, default: 0
  end
end
