class BlogsController < ApplicationController
    def index
        @user = User.find(params[:id])
        @grams = Gram.where(user_id: params[:id]).send('published').order('insta_posted_date DESC')
        render layout: 'public'
    end

    def show
        @user = User.find(params[:id])
        @gram = Gram.find(params[:post_id])
        render layout: 'public'
    end
end