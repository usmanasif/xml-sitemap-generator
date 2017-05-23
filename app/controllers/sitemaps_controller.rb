class SitemapsController < ApplicationController
  def index
    @sitemaps = Sitemap.all
    @new_sitemap = Sitemap.new
  end

  def generate_sitemap
    sitemap = Sitemap.find(params[:sitemap_id])
    sitemap.links.destroy_all
    @url_map = Hash.new { |hash,key| hash[key] = [] }

    Spidr.site(sitemap.url) do |spider|
      spider.every_link do |origin,dest|
        @url_map[dest] << origin
        link = sitemap.links.new(
            loc: origin,
            last_mod: Time.now.strftime('%Y-%m-%d'),
            prority: 0.5
        )
        if link.valid?
          link.save
        end
      end
    end
    @links = sitemap.links
    redirect_to sitemap_path(id: sitemap.id)
  end

  def download
    @sitemap = Sitemap.find(params[:id])
    # render xml: @sitemap.links, content_type: "application/xml"
    #render xml: @sitemap.generate_xml, filename: 'my_file2.xml', content_type: "application/xml", :disposition => 'attachment'

    # respond_to do |format|
    #   format.xml
    # end
    # respond_to do |format|
    #   format.xml { render layout: 'layouts/test.xml.erb', filename: 'my_file.xml' }
    # end
    # respond_to do |format|
    #   format.html
    #   format.xml { send_file :filename => 'mydoc.xml', :type=>"application/xml", :disposition => 'attachment' }
    # end
  end

  def show
    @sitemap = Sitemap.find(params[:id])
    @links = @sitemap.links
  end

  def create
    @sitemap = Sitemap.create(sitemap_params)
    if @sitemap.save
      redirect_back(fallback_location: :back,notice: "New sitemap added.")
    else
      redirect_back(fallback_location: :back,notice: "Failed to create new sitemap.")
    end
  end

  private

  def sitemap_params
    params.require(:sitemap).permit(:url)
  end
end
