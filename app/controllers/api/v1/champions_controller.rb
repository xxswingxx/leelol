class Api::V1::ChampionsController < Api::V1::BaseController
  respond_to :json

  def index
    @champions = params[:q].present? ? Champion.where('name ~* ?', params[:q]) : Champion.all
    respond_with(@champions)
  end

  def show
    @champion = is_number?(params[:id]) ? Champion.find(params[:id]) : Champion.find_by_name(params[:id].downcase.capitalize)
    if @champion
      respond_with(@champion)
    else
      render json: { error: 'Cannot find champions with that ID/name'}, status: 404
    end
  end
end