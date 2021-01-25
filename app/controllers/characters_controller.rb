class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  # GET /characters
  # GET /characters.json
  def index
    @characters = Character.all
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    @gun_category = GunCategory.find(@character.gun_category_id).name
    @country = Country.find(@character.country_id).name 
    @information = @character.information
  end

  # GET /characters/new
  def new
    @character = Character.new
    @character.information.build
  end

  # GET /characters/1/edit
  def edit
    @character.information.build
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
          :_destroy
        ]
      )
    end
end