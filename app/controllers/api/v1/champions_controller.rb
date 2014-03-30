class Api::V1::ChampionsController < Api::V1::BaseController
  respond_to :json

  def index
  	@champions = params[:q].present? ? Champion.where('name ilike ?', params[:q]) : Champion.all
  	respond_with(@champions)
  end

  def show
  	@champion = Champion.find(params[:id])
  	respond_with(@champion)
  end
end