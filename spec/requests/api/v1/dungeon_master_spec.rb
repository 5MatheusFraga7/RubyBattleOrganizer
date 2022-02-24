require 'rails_helper'

RSpec.describe 'DungeonMasterController' do 

    # Generates monster
    # Generates players
    # Setup initiative?
    
    let!(:user) { FactoryBot.create(:user) }
    let!(:dungeon_master_test) { FactoryBot.create(:dungeon_master, user_id: user.id) }

    let(:headers) do 
        {
            'Content-type'  => Mime[:json].to_s,
            'Authorization' => user.auth_token
        }
    end 

    context 'REST DUNGEON MASTER' do 
    
        describe 'GET INDEX' do 

            it 'status code 200' do 
    
                get '/api/v1/dungeon_master/dungeon_master', params: {  }, headers: headers
                expect(response).to have_http_status(200)
            
            end 
        
        end
    
        describe 'GET SHOW' do 
    
            let(:dungeon_master) { FactoryBot.create(:dungeon_master) }
    
            it 'statuc code 200' do 
                get "/api/v1/dungeon_master/dungeon_master/#{ dungeon_master.id }", params: { }, headers: headers
                expect(response).to have_http_status(200) 
            end 
    
        end 
    
        describe 'POST CREATE' do 
    
            let(:dungeon_master) { FactoryBot.attributes_for(:dungeon_master) }
    
            before do 
                post '/api/v1/dungeon_master/dungeon_master', params: { dungeon_master: dungeon_master }.to_json, headers: headers
            end 
    
            it 'status code 201' do
                expect(response).to have_http_status(201)
            end 
    
            it 'created dungeon master' do
                expect(DungeonMaster.where(name: dungeon_master[:name]).first).not_to be_nil
            end
        end
    
        describe 'PUT UPDATE' do 
    
            let(:dungeon_master) { FactoryBot.create(:dungeon_master, user_id: user.id) }
            let(:dungeon_master_attributes) { { name: 'New name updated--------------' } }
    
            before do 
                put "/api/v1/dungeon_master/dungeon_master/#{dungeon_master.id}", params: { dungeon_master: dungeon_master_attributes }.to_json, headers: headers
            end
    
            it 'status code 201' do 
                expect(response).to have_http_status(201)
            end
    
            it 'updated dungeon master in database' do
                
                expect(DungeonMaster.where(name: dungeon_master_attributes[:name])).not_to be_nil 
    
            end
        
        end 
    
        describe 'DELETE ACTION' do
            
            let!(:dungeon_master) { FactoryBot.create(:dungeon_master, user_id: user.id) }
    
            before do 
                delete "/api/v1/dungeon_master/dungeon_master/#{dungeon_master.id}", params: { }.to_json, headers: headers
            end 
    
            it 'status code 204' do
                expect(response).to have_http_status(204)
    
            end
    
            it 'dungeon removed!' do
                expect(DungeonMaster.find_by(id: dungeon_master.id)).to be_nil
            end
    
        end 


    end 

    context 'DM BATTLEFIELD' do 

        describe 'POST CREATE BATTLEFIELD' do 

            let(:battle_field) { FactoryBot.create(:battle_field, dungeon_master_id: dungeon_master_test.id) }

            it  'status code 201' do 
    
                post '/api/v1/dungeon_master/create_battlefield', params: { battle_field: battle_field }.to_json, headers: headers
                expect(response).to have_http_status(201)
            end 
    
        end

        describe 'GET SHOW BATTLEFIELD' do 

            let(:battle_field) { FactoryBot.create(:battle_field, dungeon_master_id: dungeon_master_test.id) }
    
            it 'status code 200' do 
                get "/api/v1/dungeon_master/show_battle_fields", params: { dungeon_master_id: dungeon_master_test.id }, headers: headers
                expect(response).to have_http_status(200) 
            end 
        end 
    
        describe 'PUT UPDATE BATTLEFIELD' do 
    
            let(:battle_field) { FactoryBot.create(:battle_field, dungeon_master_id: dungeon_master_test.id) }
            let(:battle_field_attributes) { { title: 'New title updated--------------' } }
    
            before do 
                put "/api/v1/dungeon_master/update_battle_field/#{battle_field.id}", params: { battle_field: battle_field_attributes, dungeon_master_id: dungeon_master_test.id }.to_json, headers: headers
            end
    
            it 'status code 201' do 
                expect(response).to have_http_status(201)
            end
    
            it 'updated battle_field master in database' do
                
                expect(BattleField.where(title: battle_field_attributes[:name])).not_to be_nil 
            end
        
        end 
    
        describe 'DELETE ACTION BATTLEFIELD' do
            
            let(:battle_field) { FactoryBot.create(:battle_field, dungeon_master_id: dungeon_master_test.id) }
    
            before do 
                delete "/api/v1/dungeon_master/destroy_battle_field/#{battle_field.id}", params: { dungeon_master_id: dungeon_master_test.id }.to_json, headers: headers
            end 
    
            it 'status code 204' do
                expect(response).to have_http_status(204)
            end
    
            it 'field removed!' do
                expect(BattleField.find_by(id: battle_field.id)).to be_nil
            end
    
        end 

    end 

    context 'DM PLAYER' do 

        describe 'POST CREATE PLAYER' do 

            let(:player) { FactoryBot.create(:player, dungeon_master_id: dungeon_master_test.id) }

            it  'status code 201' do 
    
                post '/api/v1/dungeon_master/create_player', params: { player: player }.to_json, headers: headers
                expect(response).to have_http_status(201)
            end 
    
        end

        describe 'GET SHOW PLAYER' do 

            let(:player) { FactoryBot.create(:player, dungeon_master_id: dungeon_master_test.id) }
    
            it 'status code 200' do 
                get "/api/v1/dungeon_master/show_players", params: { dungeon_master_id: dungeon_master_test.id }, headers: headers
                expect(response).to have_http_status(200) 
            end 
        end 
    
        describe 'PUT UPDATE PLAYER' do 
    
            let(:player) { FactoryBot.create(:player, dungeon_master_id: dungeon_master_test.id) }
            let(:player_attributes) { { title: 'New title updated--------------' } }
    
            before do 
                put "/api/v1/dungeon_master/update_player/#{player.id}", params: { player: player_attributes, dungeon_master_id: dungeon_master_test.id }.to_json, headers: headers
            end
    
            it 'status code 201' do 
                expect(response).to have_http_status(201)
            end
    
            it 'updated battle_field master in database' do
                
                expect(Player.where(title: player_attributes[:name])).not_to be_nil 
            end
        
        end 
    
        describe 'DELETE ACTION BATTLEFIELD' do
            
            let(:player) { FactoryBot.create(:player, dungeon_master_id: dungeon_master_test.id) }
    
            before do 
                delete "/api/v1/dungeon_master/destroy_player/#{player.id}", params: { dungeon_master_id: dungeon_master_test.id }.to_json, headers: headers
            end 
    
            it 'status code 204' do
                expect(response).to have_http_status(204)
            end
    
            it 'field removed!' do
                expect(Player.find_by(id: player.id)).to be_nil
            end
    
        end 

    end 

    context 'DM MONSTER' do 

        describe 'POST CREATE MONSTER' do 

            let(:dm_monster) { FactoryBot.create(:dm_monster, dungeon_master_id: dungeon_master_test.id) }

            it  'status code 201' do 
    
                post '/api/v1/dungeon_master/create_monster', params: { dm_monster: dm_monster }.to_json, headers: headers
                expect(response).to have_http_status(201)
            end 
    
        end

        describe 'GET SHOW MONSTER' do 

            let(:dm_monster) { FactoryBot.create(:dm_monster, dungeon_master_id: dungeon_master_test.id) }
    
            it 'status code 200' do 
                get "/api/v1/dungeon_master/show_monsters", params: { dungeon_master_id: dungeon_master_test.id }, headers: headers
                expect(response).to have_http_status(200) 
            end 
        end 
    
        describe 'PUT UPDATE MONSTER' do 
    
            let(:dm_monster) { FactoryBot.create(:dm_monster, dungeon_master_id: dungeon_master_test.id) }
            let(:dm_monster_attributes) { { title: 'New title updated--------------' } }
    
            before do 
                put "/api/v1/dungeon_master/update_monster/#{dm_monster.id}", params: { dm_monster: dm_monster_attributes, dungeon_master_id: dungeon_master_test.id }.to_json, headers: headers
            end
    
            it 'status code 201' do 
                expect(response).to have_http_status(201)
            end
    
            it 'updated battle_field master in database' do
                
                expect(DmMonster.where(title: dm_monster_attributes[:name])).not_to be_nil 
            end
        
        end 
    
        describe 'DELETE ACTION MONSTER' do
            
            let(:dm_monster) { FactoryBot.create(:dm_monster, dungeon_master_id: dungeon_master_test.id) }
    
            before do 
                delete "/api/v1/dungeon_master/destroy_monster/#{dm_monster.id}", params: { dungeon_master_id: dungeon_master_test.id }.to_json, headers: headers
            end 
    
            it 'status code 204' do
                expect(response).to have_http_status(204)
            end
    
            it 'field removed!' do
                expect(DmMonster.find_by(id: dm_monster.id)).to be_nil
            end
    
        end 

    end 
    

end 