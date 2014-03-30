class Api::V1::ItemsController < Api::V1::BaseController
  respond_to :json

  def index
  	@items = params[:q].present? ? Item.where('name ~* ?', params[:q]) : Item.all
  	respond_with @items
  end

  def show
    if @item = Item.find_by_id(params[:id])
      respond_with(@item)
    else
      render json: { error: 'Cannot find any item with that ID/name'}, status: 404
    end
  end
end