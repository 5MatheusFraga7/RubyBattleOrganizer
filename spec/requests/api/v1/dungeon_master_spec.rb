require 'rails_helper'

RSpec.describe 'DungeonMasterController' do 

    # Generates monster
    # Generates players
    # Setup initiative?
    
    let!(:user) { FactoryBot.create(:user) }
    let(:headers) do 
        {
            'Content-type'  => Mime[:json].to_s,
            'Authorization' => user.auth_token
        }
    end 

    describe 'GET INDEX' do 

        it 'status code 200' do 

            get '/api/v1/dungeon_master', params: { user_id: User.first.id }, headers: headers
            expect(response).to have_http_status(200)
        
        end 
    
    end

    describe 'POST CREATE' do 

        let(:dungeon_master) { FactoryBot.attributes_for(:dungeon_master) }

        before do 
            post '/api/v1/dungeon_master', params: { dungeon_master: dungeon_master }.to_json, headers: headers
        end 

        it 'status code 201' do
            expect(response).to have_http_status(201)
        end 

        it 'created dungeon master' do
            expect(DungeonMaster.where(name: dungeon_master[:name]).first).not_to be_nil
        end
    end
end 