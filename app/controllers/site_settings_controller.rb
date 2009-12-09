class SiteSettingsController < ApplicationController
  layout 'admin'
  before_filter :login_required
  require_role :manager
  
  def edit
    @site_settings = SiteSetting.first
  end
  
  def update
    @site_settings = SiteSetting.first
    if @site_settings.update_attributes(params[:site_setting])
      flash[:notice] = "Site Settings Updated!"
      redirect_to edit_site_settings_path
    else
      render :action => 'edit'
    end
  end
end