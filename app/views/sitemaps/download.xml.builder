xml.instruct!
xml.urlset xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  @sitemap.links.each do |link|
    xml.url do
      xml.loc link.loc
      xml.lastmod link.last_mod
      xml.changefreq 'weekly'
      xml.priority link.priority
    end
  end
end
