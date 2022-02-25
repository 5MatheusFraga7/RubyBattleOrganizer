module Api::V1::DungeonMaster::DungeonMasterPlayerBattleField

    def create_player_battle_field

        dm = ::DungeonMaster.where(user_id: current_user.id, id: params[:player_battle_field][:dungeon_master_id].to_i).first

        if (dm.nil?) 

            render json: { status: 'Dungeon master not found' }, status: 404
            return

        end

        player_battle_field = ::PlayerBattleField.new(player_battle_field_params)

        if (player_battle_field.save)
            
            render json: { player_battle_field: player_battle_field }, status: 201

        else

            render json: { status: 'saving error', errors: player_battle_field.errors }, status: 422

        end

    end

    def destroy_player_battle_field

        dm = current_user.get_dungeon_master(params[:dungeon_master_id])

        if (!dm.present?) 
            render json: { status: 'dungeon master not found' }, status: 404
            return      

        end

        player_battle_field = dm.player_battle_fields.where(id: params[:id]).first

        if (!player_battle_field.present?)

            render json: { status: 'dungeon not present' }, status: 422
            return
        end

        if (player_battle_field.destroy)

            head 204

        else

            render json: { status: 'destroy error', errors: player_battle_field.errors }, status: 422
 
        end

    end
        
    private  

	def player_battle_field_params 
		params.require(:player_battle_field).permit(:player_id, :battle_field_id)	
	end

end