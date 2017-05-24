class SitemapsController < ApplicationController

  def index
    @sitemaps = current_user.sitemaps
    @new_sitemap = current_user.sitemaps.new
  end

  def generate_sitemap
    sitemap = Sitemap.find(params[:sitemap_id])
    sitemap.links.destroy_all
    hash = {}

    Spidr.site(sitemap.url) do |spider|
      spider.every_link do |origin,dest|
        hash[origin] = "lalala" unless hash.key?(origin)
        hash[dest] = "lalala" unless hash.key?(dest)
      end
    end
    hash.keys.uniq.each do |l|
      link = sitemap.links.create(loc: l,priority: 0.5,last_mod: Time.now.strftime('%Y-%m-%d'))
    end
    redirect_to sitemap_path(id: sitemap.id)
  end

  def download
    @sitemap = Sitemap.find(params[:id])
    @links = @sitemap.links
  end

  def show
    @sitemap = Sitemap.find(params[:id])
    @links = @sitemap.links.order(:created_at)
  end

  def create
    @sitemap = current_user.sitemaps.create(sitemap_params)
    if @sitemap.save
      redirect_back(fallback_location: :back,notice: "New sitemap added.")
    else
      redirect_back(fallback_location: :back,notice: "Sitemap already exists.")
    end
  end

  private

  def sitemap_params
    params.require(:sitemap).permit(:url)
  end
end
