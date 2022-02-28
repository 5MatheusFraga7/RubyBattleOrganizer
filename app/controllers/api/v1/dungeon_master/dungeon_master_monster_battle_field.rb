module Api::V1::DungeonMaster::DungeonMasterMonsterBattleField

    def create_monster_battle_field

        dm = current_user.get_dungeon_master(params[:dungeon_master_id])

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

        monster_battle_field = MonsterBattleField.where(id: params[:id]).first

        if (monster_battle_field.nil?)
            render json: { status: 'monster_battle_field not found' }, status: 404
            return   

        end

        monster       = ::DmMonster.where(id: monster_battle_field.dm_monster_id, dungeon_master_id: params[:dungeon_master_id].to_i)
        battle_field  = ::BattleField.where(id: monster_battle_field.battle_field_id, dungeon_master_id: params[:dungeon_master_id].to_i)

        if ((monster.nil?) || (battle_field.nil?))
            render json: { status: 'Ilegal relation of monster or battle_field and dm' }, status: 404
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
		params.require(:monster_battle_field).permit(:dm_monster_id, :battle_field_id)	
	end

end