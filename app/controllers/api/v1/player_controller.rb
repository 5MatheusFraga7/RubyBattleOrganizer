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

    def show 

        player = Player.where(id: params[:id], user_id: current_user.id).first

        if (player.present?)
            
            render json: { status: 'success', player: player }, status: 200

        else

            render json: { status: 'player not found' }, status: 404

        end

    end

    def update 

        player = Player.where(id: params[:id], user_id: current_user.id).first

        if (player.nil?)
            
            render json: { status: 'player not found' }, status: 404
            return

        end

        if (player.update_attributes(player_params))

            render json: { status: 'Updated player', player: player }, status: 201

        else

            render json: { status: 'saving error', errors: player.errors }, status: 422
 
        end

    end

    def destroy 

        player = Player.where(id: params[:id], user_id: current_user.id).first

        if (player.nil?)

            render json: { status: 'player not found' }, status: 404
            return

        end
        
        if (player.destroy)

            head 204

        else

            render json: { status: 'destroy error', errors: player.errors }, status: 500

        end

    end

    private 

    def player_params
        params.require(:player).permit(:user_id, :name)
    end
end