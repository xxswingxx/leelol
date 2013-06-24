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

  def retrieve_data
    html = Nokogiri::HTML(open('http://leagueoflegends.wikia.com/wiki/Base_champion_statistics'))
    images = Nokogiri::HTML(open('http://www.mobafire.com/league-of-legends/champions'))
    length = html.at_css('table.wikitable.sortable').children().length

    i = 1
    html.at_css('table.wikitable.sortable').children()[1..length-1].each do |champion|
      image = images.at_css('div.self-clear#browse-build').children()[i].children[1].get_attribute('src')
      champion_stats = Champion.parse(champion, image)
      Champion.create(champion_stats)
      i = i + 2
    end
    redirect_to champions_path
  end

  def recalculate_stats
    @champion = Champion.find(params[:id])
    @champion.recalculate_stats(params[:champion])
    render template: 'champions/show'
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
