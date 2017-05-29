xml.instruct!
xml.urlset xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  @sitemap.links.order(:created_at).each do |link|
    xml.url do
      xml.loc link.loc
      xml.lastmod link.lastmod
      xml.changefreq link.changefreq
      xml.priority link.priority
    end
  end
end
