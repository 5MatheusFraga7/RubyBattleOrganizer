class Api::V1::PlayerController < ApplicationController
    before_action :authenticate_with_token!

    def index 

        players = Player.where(user_id: params[:id])

        render json: { status: 'success', players: players }, status: 200

    end

end