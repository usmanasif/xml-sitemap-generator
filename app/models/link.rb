class Link < ApplicationRecord
  belongs_to :sitemap
  validates :loc, uniqueness: { scope: :sitemap }

  def age_in_months
    return 3
  end
end
