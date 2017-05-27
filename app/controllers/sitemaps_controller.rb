class SitemapsController < ApplicationController
  before_filter :find_sitemap, only: [:download, :show, :generate]

  def index
    @sitemaps = current_user.sitemaps
    @new_sitemap = current_user.sitemaps.new
  end

  def generate
    @sitemap.delay.get_links

    redirect_to sitemaps_path, notice: 'your sitemap is being generated'
  end

  def download
  end

  def show
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

  def find_sitemap
    @sitemap = Sitemap.find(params[:id])
  end
end
