# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  # You can move this into a different controller, if you wish.  This module gives you the require_role helpers, and others.
  include RoleRequirementSystem
  include SslRequirement
  before_filter :get_site_settings

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :card_number, :verification_number, :expiration_month, :expiration_year
  
  def render_404 
    respond_to do |format| 
      format.html { render :file => "#{RAILS_ROOT}/public/404.html", :status => '404 Not Found' } 
      format.xml  { render :nothing => true, :status => '404 Not Found' } 
    end 
    true 
  end 
   
  def rescue_action_in_public(e) 
    case e when ActiveRecord::RecordNotFound 
      render_404 
    else 
      super 
    end 
  end
  
  private
  def get_site_settings
    @site_settings = SiteSetting.first
  end
end
