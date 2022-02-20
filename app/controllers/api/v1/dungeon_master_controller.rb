class Api::V1::DungeonMasterController < ApplicationController

    before_action :authenticate_with_token!

    def index 

        user_id = (current_user.nil?) ? params[:user_id].to_i : current_user.id

        dm =  DungeonMaster.where(user_id: user_id)
        render json: { status: 'success', dungeon_master: dm }, status: 200

    end

    def create 

        dm = DungeonMaster.create(dungeon_master_params)
        render json: { status: "created", dungeon_master: dm }, status: 201
        
    end

    private  

	def dungeon_master_params 
		params.require(:dungeon_master).permit(:name, :user_id)	
	end
end
