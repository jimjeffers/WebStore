class ProjectsController < InheritedResources::Base
  layout 'admin'
  before_filter :login_required
  respond_to :html, :xml
end