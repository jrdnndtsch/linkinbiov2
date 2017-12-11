class GramsController < ApplicationController
  before_action :set_gram, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /grams
  # GET /grams.json
  def index
    filter = params['filter_grams'] || 'all_selected'
    order = params['order_grams'] || 'most_recent'
    @current_user_grams =  Gram.where(user_id: current_user.id)
    @grams = Gram.where(user_id: current_user.id).send(filter).send(order)
   
    # @grams = Gram.all.where(user_id: current_user.id, selected: true).order('insta_posted_date DESC')

  end

  # GET /grams/1
  # GET /grams/1.json
  def show
  end

  # GET /grams/new
  def new
    @gram = Gram.new
    if current_user.present?
        @user_grams_existing = Gram.all.where(user_id: current_user.id, selected: false)
        if @user_grams_existing.present?
          @user_grams = @user_grams_existing.order('insta_posted_date DESC')
        else 
          current_user.authenticate_and_import_gram
          @user_grams = Gram.all.where(user_id: current_user.id, selected: false).order('insta_posted_date DESC')
        end
    end
  end

  # GET /grams/1/edit
  def edit
  end

  # POST /grams
  # POST /grams.json
  def create
    @gram = Gram.new(gram_params)
    respond_to do |format|
      if @gram.save
        format.html { redirect_to @gram, notice: 'Gram was successfully created.' }
        format.json { render :show, status: :created, location: @gram }
      else
        format.html { render :new }
        format.json { render json: @gram.errors, status: :unprocessable_entity }
      end
    end
  end

  def import
    if current_user.present?
      current_user.authenticate_and_import_gram
    end
  end

  def filter
    filter = params['filter_grams'].to_sym
    order = params['order_grams'].to_sym
    @grams = Gram.send(filter).send(order)
    respond_to do |format|
      format.js
    end 
  end

 

  # PATCH/PUT /grams/1
  # PATCH/PUT /grams/1.json
  def update
    filter = params['filter_grams'] || 'all_selected'
    order = params['order_grams'] || 'most_recent'
    @current_user_grams =  Gram.where(user_id: current_user.id)
    @grams = Gram.where(user_id: current_user.id).send(filter).send(order)
    respond_to do |format|
      if @gram.update(gram_params)
        format.html { redirect_to @gram, notice: 'Gram was successfully updated.' }
        format.json { render :show, status: :ok, location: @gram }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @gram.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grams/1
  # DELETE /grams/1.json
  def destroy
    @gram.destroy
    respond_to do |format|
      format.html { redirect_to grams_url, notice: 'Gram was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gram
      @gram = Gram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gram_params
      params.require(:gram).permit(:image_url, :link, :blog_text, :post_type, :published, :insta_posted_date, :user_id)
    end
end
