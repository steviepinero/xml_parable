class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  # before_save :parse_file

  def parse_file
    tempfile = blueprint.queued_for_write[:original]
    doc = Nokogiri::XML(tempfile)
    parse_xml(doc)
  end

 def parse_xml(doc)
   doc.root.elements.each do |node|
     parse_blueprints(node)
   end
 end

 def parse_blueprints(node)
   if node.node_name.eql? 'blp'
     node.elements.each do |node|
       parse_blueprint_segments(node)
     end
   end
 end

def parse_blueprint_segments(node)
  if node.node_name.eql? 'blpseg'
    tmp_segment = Blueprintsegment.new
    node.elements.each do |node|
      parse_points(node,tmp_segment)
    end
    self.blueprintsegments << tmp_segment
  end
end

def parse_points(node,tmp_segment)
  if node.node_name.eql? 'blppt'
    tmp_point = Point.new
    tmp_point.high = node.attr("high")
    tmp_point.low = node.attr("low")
    node.elements.each do |node|
      tmp_point.name = node.text.to_s if node.name.eql? 'name'
      tmp_point.pts = node.text.to_s if node.name.eql? 'points'
      tmp_point.description = node.text.to_s if node.name.eql? 'desc'
      tmp_point.point_created_at = node.text.to_s if node.name.eql? 'time'
    end
    tmp_segment.points << tmp_point
  end
end

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.permit(:name, :blueprint, :items, :points)
    end
end
