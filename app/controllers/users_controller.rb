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
     @user.account = Account.new
     if @user.save
       @user.create_account
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
  # GET /users.xml
  def index
    @users = current_user.developers

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    #@user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    #@user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    #@user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    #@user = User.new(params[:user])

    respond_to do |format|
      if @user.save_without_session_maintenance
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    #@user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    #@user = User.find(params[:id])

    if @user.id == current_user.id
      flash.now[:notice] = 'You have just destroyed yourself. Destroying your session too'
      current_user_session.destroy
    end

    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
