Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'home#index'
  devise_for :users

  namespace :api, defaults: { format: :json }, path: '/api' do 

    namespace :v1, path: '/v1' do

      namespace :dungeon_master, path: '/dungeon_master' do

        resources :dungeon_master, only: [:index, :create, :show, :update, :destroy]

        post 'create_battlefield'      => "dungeon_master#create_battlefield"
        get  'show_battle_fields'      => "dungeon_master#show_battle_fields"
        put  'update_battle_field/:id' => "dungeon_master#update_battle_field"
       
      end

      resources :player, only: [:index, :create, :show, :update, :destroy]

    end

  end

end
