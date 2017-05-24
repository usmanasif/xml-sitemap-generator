class Sitemap < ApplicationRecord
  belongs_to :user
  has_many :links
  validates :url, uniqueness: { scope: :user }
end

