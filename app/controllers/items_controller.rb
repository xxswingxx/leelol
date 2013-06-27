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
    html = Nokogiri::HTML(open('http://www.mobafire.com/league-of-legends/items'))

    html.at_css('#browse-items').css('a.champ-box').each do | item|
      id = item.get_attribute('href').match(/\d+$/).to_a.first
      item_stats = Nokogiri::HTML(open("http://www.mobafire.com/ajax/tooltip?relation_type=Item&relation_id=#{id}")).text.strip().gsub("\r\n", '').split("\t").reject {|c| c.empty?}

      # 0 -> Name
      # 1 -> Total price
      # 2 -> Recipe price
      # 3 -> Stats&descr

      image = item.at_css('img').get_attribute('src')
      name = item_stats[0].gsub('Classic Only', '').gsub('Dominion Only', '')
      cost = item_stats[1].split(': ').last

      desc = "@ #{item_stats[3].gsub(/UNIQUE\s[\w\W]*/, '')}".scan(/[@,]\s(\d+\s[A-Z][\s*\w*]+)/)
      uniques = item_stats[3].match(/UNIQUE\s[\w\W]*/).to_a

      stats = Hash.new
      #Just in case if these are boots
      movement_speed = item_stats[3].scan(/(\d+) Movement Speed/).flatten.first
      stats.merge!(movement_speed: movement_speed)  if movement_speed.present?
      desc.flatten.each do |stat|
        value = stat.scan(/\d+/).flatten.first
        key = stat.gsub("#{value} ", '').downcase.gsub(' ', '_').to_sym
        stats.merge!(key => value)
      end
      Item.create( image: image, name: name, cost: cost, stats: stats, passive: uniques)
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