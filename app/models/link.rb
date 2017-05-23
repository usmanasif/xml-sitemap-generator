class Link < ApplicationRecord
  belongs_to :sitemap
  validates :loc,uniqueness: true
end
