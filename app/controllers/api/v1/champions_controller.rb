class Api::V1::ChampionsController < Api::V1::BaseController
  respond_to :json

  def index
    @champions = params[:q].present? ? Champion.where('name ~* ?', params[:q]) : Champion.all
    respond_with(@champions)
  end

  def show
    if @champion = Champion.find_by_id(params[:id])
      respond_with(@champion)
    else
      render json: { error: 'Cannot find any champion with that ID/name'}, status: 404
    end
  end
end