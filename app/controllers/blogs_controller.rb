class BlogsController < ApplicationController
    def index
        @user = User.friendly.find(params[:id])
        @grams = Gram.where(user_id: @user.id).send('published').order('insta_posted_date DESC')
        render layout: 'public'
    end

    def show
        @user = User.friendly.find(params[:id])
        @gram = Gram.friendly.find(params[:post_id])
        render layout: 'public'
    end
end