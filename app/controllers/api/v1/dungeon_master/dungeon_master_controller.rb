class Api::V1::DungeonMaster::DungeonMasterController < ApplicationController

    include DungeonMasterBattlefield
    include DungeonMasterPlayer
    include DungeonMasterMonster

    before_action :authenticate_with_token!

    def index 

        dm =  ::DungeonMaster.where(user_id: current_user.id)
        render json: { status: 'success', dungeon_master: dm }, status: 200

    end

    def show 

        dm = DungeonMaster.where(id: params[:id], user_id: current_user.id)
        render json: dm, status: 200

    end

    def create 

        dm = DungeonMaster.create(dungeon_master_params)
        render json: { status: "created", dungeon_master: dm }, status: 201
        
    end

    def update 

        if (current_user.nil?)
            render json: { status: 'Unauthorized Access' }, status: 401
        end

        if (params[:id].nil?)
            render json: { status: 'Invalid Params' }, status: 422
        end

        dm = DungeonMaster.where(id: params[:id].to_i, user_id: current_user.id).first

        if ((dm.present?) && (dm.update_attributes(dungeon_master_params)))

            render json: { status: 'Updated Success', dungeon_master: dm }, status: 201 

        elsif (dm.nil?)

            render json: { status: 'Dungeon master not found' }, status: 404

        else

            render json: { status: 'Saving Error', errors: dm.errors }, status: 422

        end

    end

    def destroy 

        dm = DungeonMaster.where(user_id: current_user.id, id: params[:id]).first

        if (dm.nil?)
   
            render json: { status: 'Dungeon master not found' }, status: 404

        end

        if (dm.destroy)

            head 204

        else

            render json: { status: 'Error in destroy dungeon master', errors: dm.errors }, status: 422
        end
    
    end
        
    private  

	def dungeon_master_params 
		params.require(:dungeon_master).permit(:name, :user_id)	
	end
end
