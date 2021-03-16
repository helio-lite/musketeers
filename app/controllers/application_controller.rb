class ApplicationController < ActionController::Base

  def take_params

    @gun_category = params[:gun_category].present? ? {gun_category_id: params[:gun_category][:gun_category_id]} : nil
    {
     :keyword => params[:keyword],
     :gun_category => @gun_category,
     :gun_type => params[:gun_type],
     :country => params[:country],
     :page     => params[:page],
     :per_page => params[:per_page]
    }
  end 
  helper_method :take_params

end
