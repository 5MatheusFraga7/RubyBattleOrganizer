module Api::V1::DungeonMaster::DungeonMasterBattlefield 

    def create_battlefield

        dm = ::DungeonMaster.where(user_id: current_user.id, id: params[:battle_field][:dungeon_master_id].to_i).first

        if (dm.nil?) 

            render json: { status: 'Dungeon master not found' }, status: 404
            return

        end

        battle_field = ::BattleField.new(battle_field_params)

        if (battle_field.save)
            
            render json: { battle_field: battle_field }, status: 201

        else

            render json: { status: 'saving error', errors: battle_field.errors }, status: 422

        end

    end

    def show_battle_fields

        dm = DungeonMaster.where(id: params[:id], user_id: current_user.id)
        render json: dm, status: 200

    end

    def update_battle_field

        if (current_user.nil?)
            render json: { status: 'Unauthorized Access' }, status: 401
        end

        if (params[:id].nil?)
            render json: { status: 'Invalid Params' }, status: 422
        end

    end

    def destroy_battle_field

    
    end
        
    private  

	def battle_field_params 
		params.require(:battle_field).permit(:title, :dungeon_master_id)	
	end

end