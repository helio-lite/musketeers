class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  # GET /characters
  # GET /characters.json
  def index
    if params[:commit] == "Search"
      keyword = params[:keyword]
      category = params[:gun_category][:gun_category_id]
      country = params[:country]
      @characters = Character.search_result(keyword, category, country).with_attached_images.page(params[:page]).per(5)
    else
      @characters = Character.all.with_attached_images.page(params[:page]).per(5)
    end
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    @gun_category = GunCategory.find(@character.gun_category_id).name
    @country = Country.find(@character.country_id).name 
    @information = @character.information.order(:title_id) #千銃士/千銃士Rの順にする
  end

  # GET /characters/new
  def new
    @character = Character.new
    2.times{@character.information.build}
  end

  # GET /characters/1/edit
  def edit
    if @character.information.count == 0
      2.times{@character.information.build}
    else
      @character.information.build if @character.information.count == 1
    end
  end

  # POST /characters
  # POST /characters.json
  def create
    @character = Character.new(character_params)

    respond_to do |format|
      if @character.save
        format.html { redirect_to @character, notice: 'Character was successfully created.' }
        format.json { render :show, status: :created, location: @character }
      else
        format.html { render :new }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /characters/1
  # PATCH/PUT /characters/1.json
  def update
    #チェック入り画像は削除する
     if params[:character][:image_ids].present?
       ids = params[:character][:image_ids]
       ids.each do |id|
         image = @character.images.find(id)
         image.purge
       end
     end

    respond_to do |format|
      if @character.update(character_params)
        format.html { redirect_to @character, notice: 'Character was successfully updated.' }
        format.json { render :show, status: :ok, location: @character }
      else
        format.html { render :edit }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  def destroy
    @character.images.purge #紐づいている画像も削除
    @character.destroy
    respond_to do |format|
      format.html { redirect_to characters_url, notice: 'Character was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def character_params
      params.require(:character).permit(
        :name_ja,
        :name_en,
        :name_gun,
        :gun_category_id,
        :gun_type_id,
        :country_id,
        :motif,
        #Active Storageの画像用パラメータ
        images: [],
        #無印とRの情報
        information_attributes: [
          :id,
          :character_id,
          :title_id,
          :introduction,
          :height,
          :hobby,
          :favorite,
          #チェックボックスで_destroyチェック入りなら削除になる
          :_destroy
        ]
      )
    end
end
