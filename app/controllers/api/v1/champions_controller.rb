class Api::V1::ChampionsController < Api::V1::BaseController
  respond_to :json

  def index
  	@champions = Champion.all
  	respond_with(@champions)
  end

  def show
  	@champion = Champion.find(params[:id])
  	respond_with(@champion)
  end
end