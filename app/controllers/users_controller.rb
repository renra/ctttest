class UsersController < ApplicationController
  before_filter :require_auth, :only => :index
  load_and_authorize_resource :except => [:login, :logout, :signup, :index]

  def login
    @user_session = UserSession.new

    if request.post?
      # just to be sure, seems like authlogic does not reset it by itself
      reset_session
      session = UserSession.new(params[:user_session])
      if session.save
        flash[:notice] = 'User authenticated. Welcome inside.'
        redirect_to projects_path
      else
        flash[:error] = 'Authentication failed. Raising an eybrow.'
      end
    end
  end

  def signup
   @user = User.new
   if request.post?
     # mass assignment protection for id in application.rb
     @user.attributes = params[:user]
     if @user.save_with_account_and_become_team_member
       flash[:notice] = 'Congratulations. You have signud up succesfully'
       redirect_to root_path
     end
   end
  end

  def logout
    current_user_session.destroy
    flash[:notice] = 'Goodbye. Remember me well.'
    redirect_to login_path
  end
 

  # GET /users
  def index
    @users = current_user.account.team_members

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /users/1
  def show
    #@user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /users/new
  def new
    #@user = User.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/1/edit
  def edit
    #@user = User.find(params[:id])
  end

  # POST /users
  def create
    #@user = User.new(params[:user])
    @user.generate_password

    respond_to do |format|
      if @user.save_without_session_maintenance
        current_user.add_team_member( current_user.account.id, @user )
        Postman.invitation(@user.email, @user.password).deliver

        format.html { redirect_to(users_path, :notice => 'User was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /users/1
  def update
    #@user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /users/1
  def destroy
    #@user = User.find(params[:id])

    if @user.id == current_user.id
      flash.now[:notice] = 'You have just destroyed yourself. Destroying your session too'
      current_user_session.destroy
    end

    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
    end
  end
end
