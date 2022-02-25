Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'home#index'
  devise_for :users

  namespace :api, defaults: { format: :json }, path: '/api' do 

    namespace :v1, path: '/v1' do

      namespace :dungeon_master, path: '/dungeon_master' do

        resources :dungeon_master, only: [:index, :create, :show, :update, :destroy]

        # Battle Field

        post   'create_battlefield'       => "dungeon_master#create_battlefield"
        get    'show_battle_fields'       => "dungeon_master#show_battle_fields"
        put    'update_battle_field/:id'  => "dungeon_master#update_battle_field"
        delete 'destroy_battle_field/:id' => "dungeon_master#destroy_battle_field"
       
        # Player

        post   'create_player'      => "dungeon_master#create_player"
        get    'show_players'       => "dungeon_master#show_players"
        put    'update_player/:id'  => "dungeon_master#update_player"
        delete 'destroy_player/:id' => "dungeon_master#destroy_player"

        # Monster

        post   'create_monster'      => "dungeon_master#create_monster"
        get    'show_monsters'       => "dungeon_master#show_monsters"
        put    'update_monster/:id'  => "dungeon_master#update_monster"
        delete 'destroy_monster/:id' => "dungeon_master#destroy_monster"

        # Player-Battlefield

        post   'create_player_battle_field'      => "dungeon_master#create_player_battle_field"
        delete 'destroy_player_battle_field/:id' => "dungeon_master#destroy_player_battle_field"

        # Monster-Battlefield

        post   'create_monster_battle_field'      => "dungeon_master#create_monster_battle_field"
        delete 'destroy_monster_battle_field/:id' => "dungeon_master#destroy_monster_battle_field"

      end

      resources :player, only: [:index, :create, :show, :update, :destroy]

    end

  end

end
