module Api::V1::DungeonMaster::DungeonMasterMonster

    def create_monster

        dm = ::DungeonMaster.where(user_id: current_user.id, id: params[:dm_monster][:dungeon_master_id].to_i).first

        if (dm.nil?) 

            render json: { status: 'Dungeon master not found' }, status: 404
            return

        end

        dm_monster = ::DmMonster.new(monster_params)

        if (dm_monster.save)
            
            render json: { dm_monster: dm_monster }, status: 201

        else

            render json: { status: 'saving error', errors: dm_monster.errors }, status: 422

        end

    end

    def show_monsters

        dm = current_user.get_dungeon_master(params[:dungeon_master_id])
        
        if (!dm.present?)

            render json: { status: 'dungeon master not found' }, status: 404
            return
        end

        render json: { status: 'success', dm_monster: dm.dm_monsters }, status: 200

    end

    def update_monster

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

        dm_monster = dm.dm_monsters.where(id: params[:id]).first

        if (!dm_monster.present?)

            render json: { status: 'monster not present' }, status: 422
            return
        end

       if (dm_monster.update_attributes(monster_params))

         render json: { status: 'monster updated', dm_monster:dm_monster  }, status: 201

       else

         render json: { status: 'saving errors', errors: dm_monster.errors }, status: 422

       end

    end

    def destroy_monster

        dm = current_user.get_dungeon_master(params[:dungeon_master_id])

        if (!dm.present?) 
            render json: { status: 'dungeon master not found' }, status: 404
            return      

        end

        dm_monster = dm.dm_monsters.where(id: params[:id]).first

        if (!dm_monster.present?)

            render json: { status: 'dungeon not present' }, status: 422
            return
        end

        if (dm_monster.destroy)

            head 204

        else

            render json: { status: 'destroy error', errors: dm_monster.errors }, status: 422
 
        end

    end
        
    private  

	def monster_params 
		params.require(:dm_monster).permit(:name, :dungeon_master_id)	
	end

end