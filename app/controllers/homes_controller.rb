class HomesController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = Team.includes(:users)
  end

  def new_invite
    @team_id = params[:team_id]
  end

  def create_invite
    User.invite!(
      {
        email: params[:email],
        name: params[:name],
        team_id: params[:team_id],
        role: params[:role],
        organization_id: current_user.organization_id
      }
    )

    redirect_to root_path, notice: "Invitation sent"
  end
end