class UsersController < ApplicationController
  layout 'admin'
  require_role :admin, :for => [:edit, :add_role, :remove_role]
  
  ssl_required :new, :create unless ENV["RAILS_ENV"] == "development"
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :login_required, :only => [:create, :suspend, :destroy, :edit, :add_role, :remove_role]
  
  
  def index
    @users = User.with_roles.not_deleted

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    redirect_to current_user unless current_user == @user || current_user.has_role?(:admin)
  end
  
  # render new.rhtml
  def new
    @user = User.new
  end
  
  def add_role
    @user = User.find(params[:user_id])
    @role = Role.find(params[:role_id])
    
    if @user.add_role(@role.name)
      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.js { render :json => {:action => "add"} }
      end
    end
  end
  
  def remove_role
    @user = User.find(params[:user_id])
    @role = Role.find(params[:role_id])
    
    if @user.remove_role(@role.name)
      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.js { render :json => {:action => "add"} }
      end
    end
  end
  
  def create
    logout_keeping_session! unless current_user.has_role?(:admin)
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      if current_user.has_role?(:admin)
        @user.add_role(:user)
        @user.activate!
        redirect_to(edit_user_path(@user))
        flash[:notice] = "New User Created!"
      else
        redirect_back_or_default('/')
        flash[:notice] = "Thanks for signing up! We're sending you an email with your activation code."
      end
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { 
          if current_user.has_role?(:admin)
            redirect_to(users_path) 
          else
            redirect_to(edit_user_path(@user))
          end
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end
  
  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_user
    @user = User.find(params[:id])
  end
end
