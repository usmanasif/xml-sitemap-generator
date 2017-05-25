class LinksController < ApplicationController

  def edit
    @link = Link.find(params[:id])
  end

  def update
    var = Link.find(params[:id])
    var.update(link_params)
    var.update_attribute(:last_mod, Time.now.strftime('%Y-%m-%d'))
    redirect_back(fallback_location: :back,notice: "Variable updated")
  end

  private

  def link_params
    params.require(:link).permit(:priority,:change_freq,:last_mod)
  end
end
