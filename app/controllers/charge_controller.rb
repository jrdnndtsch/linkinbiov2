class ChargeController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  def create

    puts "DID WE GET HERE?????"
    begin
      Stripe::Customer.create(
              :email => params[:stripeEmail],
              :source  => params[:stripeToken]
            )
      rescue Stripe::CardError => e
            puts e.message 
            puts 'ERR'
          flash[:error] = e.message
        end
  end
end
