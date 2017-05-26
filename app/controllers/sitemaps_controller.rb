class SitemapsController < ApplicationController

  def index
    @sitemaps = current_user.sitemaps
    @new_sitemap = current_user.sitemaps.new
  end

  def generate_sitemap
    sitemap = Sitemap.find(params[:sitemap_id])
    sitemap.links.destroy_all
    sitemap.delay.get_links(sitemap,current_user)
    redirect_to sitemaps_path,notice: "your sitemap is being generated"
  end

  def download
    @sitemap = Sitemap.find(params[:id])
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
