class BlogsController < ApplicationController
    def index
        @user = User.find(params[:id])
        @grams = Gram.where(user_id: params[:id]).send('published')
    end

    def show
        @gram = Gram.find(params[:post_id])
    end
end