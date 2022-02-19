require 'rails_helper'

RSpec.describe 'DungeonMasterController' do 

    # Generates monster
    # Generates players
    # Setup initiative?

    describe 'GET INDEX' do 

        it 'status code 200' do 

            get '/api/v1/dungeon_master', params: { user_id: User.first.id }
            expect(response).to have_http_status(200)
        
        end 
    
    end
end 