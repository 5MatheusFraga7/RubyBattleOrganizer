module Api::V1::DungeonMaster::DungeonMasterPlayer

    def create_player

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

    def show_players

        dm = current_user.get_dungeon_master(params[:dungeon_master_id])
        
        if (!dm.present?)

            render json: { status: 'dungeon master not found' }, status: 404
            return
        end

        render json: { status: 'success', battle_fields: dm.battle_fields }, status: 200

    end

    def update_players

        if (current_user.nil?)
            render json: { status: 'Unauthorized Access' }, status: 401
            return
        end

        if (params[:id].nil?)
            render json: { status: 'Invalid Params' }, status: 422
            return
        end

        dm = current_user.get_dungeon_master(params[:dungeon_master_id])

        if (!dm.present?) 

            render json: { status: 'dungeon master not found' }, status: 404
            return
        end

        battle_field = dm.battle_fields.where(id: params[:id]).first

        if (!battle_field.present?)

            render json: { status: 'battle field not present' }, status: 422
            return
        end

       if (battle_field.update_attributes(battle_field_params))

         render json: { status: 'battle field updated', battle_field:battle_field  }, status: 201

       else

         render json: { status: 'saving errors', errors: battle_field.errors }, status: 422

       end

    end

    def destroy_players

        dm = current_user.get_dungeon_master(params[:dungeon_master_id])

        if (!dm.present?) 
            render json: { status: 'dungeon master not found' }, status: 404
            return      

        end

        battle_field = dm.battle_fields.where(id: params[:id]).first

        if (!battle_field.present?)

            render json: { status: 'battle field not present' }, status: 422
            return
        end

        if (battle_field.destroy)

            head 204

        else

            render json: { status: 'destroy error', errors: battle_field.errors }, status: 422
 
        end

    end
        
    private  

	def player_params 
		params.require(:battle_field).permit(:title, :dungeon_master_id)	
	end

end