class Api::V1::PlayerController < ApplicationController
    before_action :authenticate_with_token!

    def index 

        players = Player.where(user_id: current_user.id)

        render json: { status: 'success', players: players }, status: 200

    end

    def create 

        player = Player.new(player_params)

        if (player.save)

            render json: { status: 'success', player: player }, status: 201

        else
            render json: { status: 'error', player: player.errors }, status: 422

        end

    end

    private 

    def player_params
        params.require(:player).permit(:user_id, :name)
    end
end