class Sitemap < ApplicationRecord
  belongs_to :user

  has_many :links
  validates :url, uniqueness: { scope: :user }

  def get_links(sitemap,user)
    hash =  Hash.new(0)
    dpus =  Hash.new(0)
    url_map = Hash.new { |hash,key| hash[key] = [] }

    Spidr.site(sitemap.url) do |spider|
      spider.every_link do |origin,dest|
        url_map[dest] << origin
        if dest.to_s.start_with?('http')
          hash[dest] = url_map[dest].length if url_map[dest].length > hash[dest]
          dpus[dest] = dest.path.to_s.split('/').length > 0 ? (dest.path.to_s.split('/').length)-1 : dest.path.to_s.split('/').length
        end
      end
    end
    url_map.keys.uniq.each do |l|
      if l.to_s.start_with?('http')
        puts url_map[l]
        ilp = url_map[l].length
        puts ilp
        dpu = l.path.to_s.split('/').length > 0 ? (l.path.to_s.split('/').length)-1 : l.path.to_s.split('/').length
        puts dpu

        lq = ilp / hash.values.max
        di = 1 / (dpu / dpus.values.max)
        dq = di /

        # formulas provided by client:
        # Link Quotient (LQ) = ilp / MAX ( ALL ( ilp))

        # Depth Index (DI) = 1 / (dpu / MAX ( ALL ( dpu)))

        # Depth Quotient (DQ) = DI / MAX ( ALL ( DI))

        # Raw Priority (RP) = ((0.35 DQ) + (0.65 LQ) / MAX ( ALL ( DQ * LQ))

        # Priority with Age Degradation = IF: changefreq = never OR changefreq = yearly , THEN: RP * (0.95 ^ (1 OR # months ago it was posted-3))

        # Minimum Priority for New Content: IF content is less than 3 months old, then Priority > 0.45





        link = sitemap.links.create(loc: l,priority: 0.5,last_mod: Time.now.strftime('%Y-%m-%d'))
      end
    end
    NotificationMailer.scheduled_demo(user).deliver
  end

end
