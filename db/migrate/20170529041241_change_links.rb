class ChangeLinks < ActiveRecord::Migration[5.0]
  def self.up
    change_table :links do |t|
      t.remove :last_mod, :change_freq
      t.string :changefreq, default: 'never'
      t.string :lastmod
      t.integer :age_in_months, default: 3
    end
  end

  def self.down
    change_table :links do |t|
      t.remove :lastmod, :changefreq, :age_in_months
      t.string :change_freq
      t.date :last_mod
    end
  end
end
