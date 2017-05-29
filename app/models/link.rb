class Link < ApplicationRecord
  belongs_to :sitemap
  validates :loc, uniqueness: { scope: :sitemap }

  before_update :update_priority

  def update_priority
    if changefreq_changed?
      if changefreq == 'never' || changefreq == 'yearly'
        final_priority = priority * (0.95 ** (age_in_months < 5 ? 1 : (age_in_months - 3)))
        self.priority = (final_priority * 100).round / 100.0
      end
    end
    if age_in_months_changed?
      if age_in_months < 3
        if priority < 0.46
          self.priority = 0.46
        end
      end
    end
    self.lastmod = Time.now.strftime('%Y-%m-%d')
  end
end
