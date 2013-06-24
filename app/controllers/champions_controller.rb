class ChampionsController < ApplicationController
  layout 'application'

  respond_to :html
  respond_to :json

  # GET /champions
  # GET /champions.json
  def index
    @champions = Champion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @champions }
    end
  end

  # GET /champions/1
  # GET /champions/1.json
  def show
    @champion = Champion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @champion }
    end
  end

  # GET /champions/new
  # GET /champions/new.json
  def new
    @champion = Champion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @champion }
    end
  end

  # GET /champions/1/edit
  def edit
    @champion = Champion.find(params[:id])
  end

  # POST /champions
  # POST /champions.json
  def create
    debugger

    @champion = Champion.new(champion_params)

    respond_to do |format|
      if @champion.save
        format.html { redirect_to @champion, notice: 'Champion was successfully created.' }
        format.json { render json: @champion, status: :created, location: @champion }
      else
        format.html { render action: "new" }
        format.json { render json: @champion.errors, status: :unprocessable_entity }
      end
    end
  end

  def my_champions
  end

  def update_stats
    @champion = Champion.find(params[:id]) 
    base_uri = 'http://leagueoflegends.wikia.com/wiki/'
    #html = Nokogiri::HTML(open("#{base_uri}#{@champion.name}"))
    
    html = Nokogiri::HTML(open(@champion.source_url)).at_css('div.box-blue').at_css('table').children
    stats = Array.new
    html.each do |e|
      stats << e.children[2].text
      stats << e.children[6].text
    end
    @champion.health = stats[0]
    @champion.crit_chance = stats[1]
    @champion.mana = stats[2]
    @champion.health_regen = stats[3]
    @champion.speed = stats[4]
    @champion.mana_regen = stats[5]
    @champion.armor = stats[6]
    @champion.range = stats[7]
    @champion.magic_res = stats[8]

    @champion.save

    redirect_to champion_path(@champion)
  end
  # PUT /champions/1
  # PUT /champions/1.json
  def update
    @champion = Champion.find(params[:id])

    respond_to do |format|
      if @champion.update_attributes(champion_params)
        format.html { redirect_to @champion, notice: 'Champion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @champion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /champions/1
  # DELETE /champions/1.json
  def destroy
    @champion = Champion.find(params[:id])
    @champion.destroy

    respond_to do |format|
      format.html { redirect_to champions_url }
      format.json { head :no_content }
    end
  end

  private
  def champion_params
    params.require(:champion).permit(:name, :lane, :image, :source_url, :health, :crit_chance, :mana, :health_regen, :speed, :mana_regen, :armor, :range, :magic_res)
  end
end
