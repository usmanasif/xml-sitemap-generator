class LinksController < ApplicationController

  def edit
    @link = Link.find(params[:id])
  end

  def update
    var = Link.find(params[:id])
    var.update(link_params)
    redirect_back(fallback_location: :back,notice: "Variable updated")
  end

  private

  def link_params
    params.require(:link).permit(:priority,:change_freq,:last_mod)
  end
end
