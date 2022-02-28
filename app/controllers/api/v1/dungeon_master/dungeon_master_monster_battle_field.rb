module Api::V1::DungeonMaster::DungeonMasterMonsterBattleField

    def create_monster_battle_field

        dm = ::DungeonMaster.where(user_id: current_user.id, id: params[:monster_battle_field][:dungeon_master_id].to_i).first

        if (dm.nil?) 

            render json: { status: 'Dungeon master not found' }, status: 404
            return

        end

        monster_battle_field = ::MonsterBattleField.new(monster_battle_field_params)

        if (monster_battle_field.save)
            
            render json: { monster_battle_field: monster_battle_field }, status: 201

        else

            render json: { status: 'saving error', errors: monster_battle_field.errors }, status: 422

        end

    end

    def destroy_monster_battle_field

        dm = current_user.get_dungeon_master(params[:dungeon_master_id])

        if (!dm.present?) 
            render json: { status: 'dungeon master not found' }, status: 404
            return      

        end

        monster_battle_field = dm.monster_battle_fields.where(id: params[:id]).first

        if (!monster_battle_field.present?)

            render json: { status: 'dungeon not present' }, status: 422
            return
        end

        if (monster_battle_field.destroy)

            head 204

        else

            render json: { status: 'destroy error', errors: monster_battle_field.errors }, status: 422
 
        end

    end
        
    private  

	def monster_battle_field_params 
		params.require(:monster_battle_field).permit(:monster_id, :battle_field_id)	
	end

end