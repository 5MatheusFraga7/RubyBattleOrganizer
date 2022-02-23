module Api::V1::DungeonMaster::DungeonMasterPlayer

    def create_player

        dm = ::DungeonMaster.where(user_id: current_user.id, id: params[:player][:dungeon_master_id].to_i).first

        if (dm.nil?) 

            render json: { status: 'Dungeon master not found' }, status: 404
            return

        end

        player = ::Player.new(player_params)

        if (player.save)
            
            render json: { player: player }, status: 201

        else

            render json: { status: 'saving error', errors: player.errors }, status: 422

        end

    end

    def show_players

        dm = current_user.get_dungeon_master(params[:dungeon_master_id])
        
        if (!dm.present?)

            render json: { status: 'dungeon master not found' }, status: 404
            return
        end

        render json: { status: 'success', players: dm.players }, status: 200

    end

    def update_player

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

        player = dm.players.where(id: params[:id]).first

        if (!player.present?)

            render json: { status: 'player not present' }, status: 422
            return
        end

       if (player.update_attributes(player_params))

         render json: { status: 'player updated', player: player }, status: 201

       else

         render json: { status: 'saving errors', errors: player.errors }, status: 422

       end

    end

    def destroy_player

        dm = current_user.get_dungeon_master(params[:dungeon_master_id])

        if (!dm.present?) 
            render json: { status: 'dungeon master not found' }, status: 404
            return      

        end

        player = dm.players.where(id: params[:id]).first

        if (!player.present?)

            render json: { status: 'player not present' }, status: 422
            return
        end

        if (player.destroy)

            head 204

        else

            render json: { status: 'destroy error', errors: player.errors }, status: 422
 
        end

    end
        
    private  

	def player_params 
		params.require(:player).permit(:name, :dungeon_master_id)	
	end

end