class ActionsController < ApplicationController
    before_action :authenticate_user!
    def get_user_gram_info
        @user = User.find(params[:id])
        @user.authenticate_and_get_user_gram_info
        respond_to do |format|
            format.html { redirect_to edit_user_registration_path, notice: 'User was successfully updated.' } 
        end 
    end
end