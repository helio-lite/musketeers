class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]
  #ヘルパーにメソッドを引き渡す
  helper_method :sort_column, :sort_direction

  # GET /characters
  # GET /characters.json
  def index
    keyword = params[:keyword].present? ? params[:keyword] : nil
    category = params[:gun_category].present? ? params[:gun_category][:gun_category_id] : nil
    gun_type = params[:gun_type].present? ? params[:gun_type] : nil
    country = params[:country].present? ? params[:country] : nil
    @characters = Character
                    .keyword(keyword)
                    .gun_category(category)
                    .gun_type(gun_type)
                    .country(country)
                    .order(sort_column => sort_direction)
                    .with_attached_images.page(params[:page]).per(5)
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    @gun_category = GunCategory.find(@character.gun_category_id).name
    @gun_type = GunType.find(@character.gun_type_id).name
    @country = Country.order(:id).find(@character.country_id).name
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
        # Active Storageの画像用パラメータ
        images: [],
        # 無印とRの情報
        information_attributes: [
          :id,
          :character_id,
          :title_id,
          :introduction,
          :height,
          :hobby,
          :favorite,
          # チェックボックスで_destroyチェック入りなら削除になる
          :_destroy
        ]
      )
    end

    #ソート対象カラムメソッド
    def sort_column
      #ソート対象カラムのホワイトリスト
      %w[name_ja name_en name_gun].include?(params[:column]) ? params[:column] : :id
    end

    #ソートasc/desc判定
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
