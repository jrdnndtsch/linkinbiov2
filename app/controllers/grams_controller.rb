class GramsController < ApplicationController
  before_action :set_gram, only: [:show, :edit, :update, :destroy, :remove]
  before_action :validate_user_on_gram, only: [:show, :edit, :update, :destroy, :remove]
  before_action :validate_insta_setup
  before_action :authenticate_user!
  # GET /grams
  # GET /grams.json
  def index
    filter = params['filter_grams'].present? ? params['filter_grams'] : 'all_selected'
    order = params['order_grams'].present? ? params['order_grams'] : 'most_recent'
    @current_user_grams =  Gram.owned_by_user(current_user.id).try(:all_selected)
    @grams = Gram.owned_by_user(current_user.id).send(filter).send(order)
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
          @user_grams = @user_grams_existing.paginate(page: params[:page]).order('insta_posted_date DESC')
        else 
          current_user.authenticate_and_import_gram
          @user_grams = Gram.all.where(user_id: current_user.id, selected: false).paginate(page: params[:page]).order('insta_posted_date DESC')
        end
    end
    respond_to do |format|
      format.html 
      format.js
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
      @user_grams = Gram.all.where(user_id: current_user.id, selected: false).paginate(page: params[:page]).order('insta_posted_date DESC')
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

  def remove
    filter = params['filter_grams'].present? ? params['filter_grams'] : 'all_selected'
    order = params['order_grams'].present? ? params['order_grams'] : 'most_recent'
    @gram.update(link: '', blog_text: '', post_type: '', published: false, selected: false, campaign_name: '', post_title: '')
    @current_user_grams =  Gram.where(user_id: current_user.id)
    @grams = Gram.where(user_id: current_user.id).send(filter).send(order)
    respond_to do |format|
      format.json { render :show, status: :ok, location: @gram }
      format.js 
    end
  end

 

  # PATCH/PUT /grams/1
  # PATCH/PUT /grams/1.json
  def update
    filter = params['filter_grams'].present? ? params['filter_grams'] : 'all_selected'
    order = params['order_grams'].present? ? params['order_grams'] : 'most_recent'
 
    @current_user_grams =  Gram.where(user_id: current_user.id)
    @grams = Gram.where(user_id: current_user.id).send(filter).send(order)
    
    if params['button'] === 'publish'
      @gram.update(published: true)
      update_message = 'Your post was successfully published'
    else  
      update_message = 'Your post was successfully updated'
    end
    respond_to do |format|
      if @gram.update(gram_params)
        # if the user is updating the content of the post and has saved redirect them to the dashboard - otherwise the the post show
        if params[:gram][:updating_the_post]
          format.html { redirect_to grams_path, notice: update_message }
        else
          format.html { redirect_to @gram, notice: update_message } 
        end
        
        format.json { render :show, status: :ok, location: @gram }
        if params[:gram][:updating_single_post]
          format.js {render 'update_single_post'}
        else 
          format.js
        end  
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
      @gram = Gram.friendly.find(params[:id])
    end

    def validate_user_on_gram
      if current_user != Gram.friendly.find(params[:id]).user
        redirect_to root_path
      end
    end

    def validate_insta_setup
      if !current_user.insta_client_token
        # redirect_to edit_user_registration_path(current_user)
        redirect_to edit_user_registration_path(current_user), notice: 'Please contact admin to set up your instagram account' 
      end     
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gram_params
      params.require(:gram).permit(:image_url, :link, :blog_text, :post_type, :published, :insta_posted_date, :user_id, :campaign_name, :selected, :post_title)
    end
end
