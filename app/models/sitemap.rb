class Sitemap < ApplicationRecord
  # belongs_to :user
  has_many :links

  def generate_xml
    # str = ''
    open('myfile2.xml', 'a') do |f|
      f << '<?xml version="1.0" encoding="UTF-8"?>'
      f << '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
      f << '<url>'
      self.links.each do |link|
        f << '<loc>' + link.loc + '</loc>'
        f << '<changefreq>daily</changefreq>'
        f << '<priority>' + link.prority.to_s + '</priority>'
        f << '</url>'
        f << '<url>'
      end
    end
  end
end

