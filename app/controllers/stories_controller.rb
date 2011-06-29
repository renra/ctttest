class StoriesController < ApplicationController
  before_filter :require_auth, :only => :index
  load_and_authorize_resource :except => [:index, :show, :adjust_order]
  authorize_resource :only => [:show, :adjust_order]

  # GET /stories
  def index
    @stories = Story.where(:project_id => params[:project_id])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /stories/1
  def show
    @story = Story.find(params[:id], :include => [:scale_level, :life_cycle_phase, :requestor, :responson])

    respond_to do |format|
      format.html # show.html.erb
    end
  end


  # GET /stories/new
  def new
    #@story = Story.new
    @project = Project.find(params[:project_id], :include => :developers)
    @levels = ScaleLevel.all
    @phases = LifeCyclePhase.available_phases

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /stories/1/edit
  def edit
    #@story = Story.find(params[:id])
    @project = Project.find(params[:project_id], :include => :developers)
    @levels = ScaleLevel.all
    @phases = LifeCyclePhase.available_phases(@story.life_cycle_phase)
  end

  # POST /stories
  def create
    @project = Project.find(params[:project_id], :include => :developers)
    @levels = ScaleLevel.all
    @phases = LifeCyclePhase.available_phases

    @story.requestor = current_user
    @story.project_id = params[:project_id]

    respond_to do |format|
      if @story.save
        format.html { redirect_to(project_story_path(@project, @story), :notice => 'Story was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /stories/1
  def update
    #@story = Story.find(params[:id])
    @project = Project.find(params[:project_id], :include => :developers)
    @levels = ScaleLevel.all
    @phases = LifeCyclePhase.available_phases(@story.life_cycle_phase)

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to(project_path(params[:project_id]), :notice => 'Story was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /stories/1
  def destroy
    #@story = Story.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to(project_url(params[:project_id])) }
    end
  end

  def adjust_order
    @stories = Story.find(params[:stories_list])
    @stories.each do |story|
      story.position = params[:stories_list].index(story.id.to_s)+1
      story.save
    end
 
    respond_to do |format|
      format.js
    end
  end

end
