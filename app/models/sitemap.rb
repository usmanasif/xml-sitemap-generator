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

        # TODO: write the following code in the event when admin will change age_in_months or changefreq.
        # Priority with Age Degradation =
        # IF: changefreq = never OR changefreq = yearly ,
        # THEN: RP * (0.95 ^ (1 OR # months ago it was posted-3))
        # final_priority = raw_priority * (0.95 ^ (link.age_in_months < 5 ? 1 : (link.age_in_months - 3)))

        # TODO: write the following code in the event when admin will change age_in_months
        # Minimum Priority for New Content: IF content is less than 3 months old, then Priority >= 0.46
        # if link.age_in_months < 3
        #   if raw_priority < 0.46
        #     raw_priority = 0.46
        #   end
        # end

        self.links.create(
            loc: link,
            priority: raw_priority,
            last_mod: Time.now.strftime('%Y-%m-%d')
        )
      end
    end

    NotificationMailer.scheduled_demo(self.user).deliver
  end

end
