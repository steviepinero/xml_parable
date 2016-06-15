class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.all
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions
  # POST /sessions.json

def create
  @user = User.find_by_name(params[:session][:name])
  if @user && @user.authenticate(params[:session][:password])
    session[:user_id] = @user.id
    redirect_to '/'
  else
    redirect_to 'login'
  end
end

def destroy
  session[:user_id] = nil
  redirect_to '/'
end
  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json


  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_session
  #     @session = Session.find(params[:id])
  #   end
  #
  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def session_params
  #     params.fetch(:session, {})
  #   end
end
