class Api::V1::DungeonMasterController < ApplicationController

    def index 

        dm =  DungeonMaster.where(user_id: current_user.id).first
        render json: { status: 'success', dungeon_master: dm }, status: 200

    end

    def create 

    end

end
