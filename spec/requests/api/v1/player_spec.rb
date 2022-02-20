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


end