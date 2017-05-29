class LinksController < ApplicationController

  def edit
    @link = Link.find(params[:id])
  end

  def update
    link = Link.find(params[:id])
    link.update(link_params)
    if params[:priority_for_all] == 'on'
      Link.where('loc like ?', "%#{link.loc}%").update_all(priority: link.priority)
    end
    if params[:changefreq_for_all] == 'on'
      Link.where('loc like ?', "%#{link.loc}%").update_all(changefreq: link.changefreq)
    end
    redirect_back(fallback_location: :back, notice: 'Variable updated')
  end

  private

  def link_params
    params.require(:link).permit(:priority, :changefreq, :lastmod, :age_in_months)
  end
end
