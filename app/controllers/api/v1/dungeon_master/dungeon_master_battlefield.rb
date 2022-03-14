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

        dm = current_user.get_dungeon_master(params[:dungeon_master_id])
        
        if (!dm.present?)

            render json: { status: 'dungeon master not found' }, status: 404
            return
        end

        render json: { status: 'success', battle_fields: dm.battle_fields }, status: 200

    end

    def update_battle_field

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

    def destroy_battle_field

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

    def to_sort_players 

        require 'json'
        players =  JSON.parse(params[:players].to_json)

        if ((players.nil?) || (players.count < 2)) 

            render json: { status: 'must be more players' }, status: 422
            return

        end

        sorted_players = players

        for i in 0..players.length

            for j in 0..players.length

                if (players[i] < players_to_change[j])

                    sorted_players[i] = players_to_change[j]
                    sorted_players[j] = players[i]

                end

            end

        end

        render json: { status: 'success', players: sorted_players }, status: 200

    end
        
    private  

	def battle_field_params 
		params.require(:battle_field).permit(:title, :dungeon_master_id)	
	end

end