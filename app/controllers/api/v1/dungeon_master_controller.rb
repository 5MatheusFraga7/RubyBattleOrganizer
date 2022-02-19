class Api::V1::DungeonMasterController < ApplicationController

    def index 

        user_id = (current_user.nil?) ? params[:user_id].to_i : current_user.id

        dm =  DungeonMaster.where(user_id: user_id).first
        render json: { status: 'success', dungeon_master: dm }, status: 200

    end

    def create 

    end
end
