class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  def retrieve_items
    html = Nokogiri::HTML(open('http://www.lolstatistics.com/items/na'))
    length = html.at_css('#outer_content').at_css('table').children().length

    html.at_css('#outer_content').at_css('table').children()[1..length].each do |img|
      stats_and_uniques = img.children.children.at_css('img').get_attribute('data-descr').split('  ')

      stats = stats_and_uniques.first.scan(/(\+\d+\%?[\s\w*]+)/)
      stats_hash = Hash.new
      stats.each do |stat|
        value = stat.first.match(/^\+\d+/)[0]
        key = stat.first.gsub(/^\+\d+/, '').strip.downcase.gsub(' ', '_').to_sym
        stats_hash.merge!({ key => value })
      end

      passives = Array.new
      if stats_and_uniques.length > 1
        stats_and_uniques[1..stats_and_uniques.length - 1].each do |unique|
          if unique =~ /Passive/
            passives << unique 
          else
            @active = unique
          end
        end
      end

      item = { name: img.children.children.at_css('img').get_attribute('data-name'), 
               image: img.children.children.at_css('img').get_attribute('data-img'), 
               stats: stats_hash, 
               passive: passives, 
               active: @active,
               cost: img.children.children.at_css('img').get_attribute('data-cost') }

      Item.create(item)
    end

    redirect_to items_path
  end

  private
    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def item_params
      params.require(:item).permit(:cost, :name, :passive, :active)
    end
end