class Link < ApplicationRecord
  belongs_to :sitemap
  validates :loc, uniqueness: { scope: :sitemap }
end
