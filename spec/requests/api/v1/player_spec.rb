require  'rails_helper'

RSpec.describe 'PlayerController' do

    let(:user) { FactoryBot.create(:user) }
    let(:headers) do 
        {
            'Content-type'  => Mime[:json].to_s,
            'Authorization' => user.auth_token
        }
    end 

    describe 'GET INDEX' do

        it 'status code 200' do
            get '/api/v1/player', params: {}, headers: headers
            expect(response).to have_http_status(200)

        end

    end

    describe 'POST CREATE' do

        let!(:player_attributes) { FactoryBot.attributes_for(:player, user_id: user.id) }

        before do 
            post "/api/v1/player", params: { player: player_attributes }.to_json, headers: headers
        end
        
        it 'status code 201' do 
            expect(response).to have_http_status(201)
        end

        it 'insert into database' do 
            expect(Player.where(user_id: user.id, name: player_attributes[:name])).not_to be_nil 
        end 

    end

    describe 'GET SHOW' do 

        let!(:player) { FactoryBot.create(:player, user_id: user.id) }

        before do 
            get "/api/v1/player/#{ player.id }", params: {  }, headers: headers
        end 

        it 'status code 200' do
            expect(response).to have_http_status(200)
        end

        it 'returns player json' do

            require 'json'
            json = JSON.parse(response.body)

            expect(json['player']['name']).to eq(player.name)

        end
    end

    describe 'PUT UPDATE' do 

        
        
    end 

end