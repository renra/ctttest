class ProjectsController < ApplicationController
  # this allows the user on the index page even if he has no projects, which I could not achieve with CanCan
  before_filter :require_auth, :only => :index
  load_and_authorize_resource :except => :index

  def assign
    @team_members = current_user.account.team_members
    @developers = current_user.developers
    if request.post?
      assigned_developers = params[:assigned_developers].nil? ? [] : params[:assigned_developers].keys
      if current_user.assign_developers(@project.id, assigned_developers)
        flash[:notice] = 'Developers updated'
        redirect_to project_path(@project)
      else
        flash[:error] = 'Developers could not be saved'
      end
    end
  end  


  # GET /projects
  def index
    @owned_projects = current_user.owned_projects
    @projects = current_user.projects

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /projects/1
  def show
    @project = Project.find(params[:id], :include => [:manager, :developers, {:stories => [:requestor, :responson, :life_cycle_phase]}])
    @counts = @project.count_stories

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /projects/new
  def new
    #@project = Project.new
    @potencional_managers = current_user.account.team_members

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /projects/1/edit
  def edit
    #@project = Project.find(params[:id])
    @potencional_managers = current_user.account.team_members
  end

  # POST /projects
  def create
    #@project = Project.new(params[:project])
    @potencional_managers = current_user.account.team_members
    @project.account_id ||= current_user.account.id

    respond_to do |format|
      if @project.save
        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /projects/1
  def update
    #@project = Project.find(params[:id])
    @potencional_managers = current_user.account.team_members
    @project.account_id ||= current_user.account.id

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /projects/1
  def destroy
    #@project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
    end
  end
end
