class Sitemap < ApplicationRecord
  belongs_to :user

  has_many :links
  validates :url, uniqueness: { scope: :user }

  def get_links
    self.links.destroy_all

    site_map_crawler = Crawler::Engine.new
    site_map_crawler.start_crawling(self.url)
    maximum_depth_of_index = site_map_crawler.maximum_depth_of_index
    maximum_dq_lq_product = site_map_crawler.maximum_dq_lq_product(maximum_depth_of_index)

    site_map_crawler.link_nodes.each do |link|
      if link.to_s.start_with?('http')
        raw_priority = site_map_crawler.raw_priority(link, maximum_depth_of_index, maximum_dq_lq_product)

        self.links.create(
            loc: link,
            priority: raw_priority,
            lastmod: Time.now.strftime('%Y-%m-%d')
        )
      end
    end
    NotificationMailer.scheduled_demo(self.user).deliver
  end

end
