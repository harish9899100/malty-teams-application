class TeamsController < ApplicationController
  def index
    @teams = current_user.organization.teams
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.organization = current_user.organization   

    if @team.save
      redirect_to root, notice: "Team created"
    else
      Rails.logger.debug @team.errors.full_messages
      render :new
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to @team
    else
      Rails.logger.debug @team.errors.full_messages
      render :edit
    end
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end
end
