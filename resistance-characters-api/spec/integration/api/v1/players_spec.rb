require 'swagger_helper'

describe 'Players API' do

  path '/api/v1/players' do
    post 'Create a player' do
      tags 'Players'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :player, in: :body, schema: {
        type: :object,
        properties: {
          name: {type: :string}
        },
        required: ['name']
      }

      response '200', 'player created' do
        let(:player) { {player: {name: 'Player 1'}} }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['players']['name']).to eq 'Player 1'
          expect(data['players']['code']).not_to eq nil
        end
      end
    end
  end

  path '/api/v1/players/{id}' do
    get 'Retrieves a player' do
      let(:current_player) { create(:player, code: 'ABC123') }
      let(:Authorization) { "Bearer #{PlayerTokenService.new('ABC123').token}" }
      let(:id) { create(:player).id }

      before do
        current_player
      end

      tags 'Players'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      security [bearerAuth: []]

      response '200', 'player found' do
        schema type: :object,
          properties: {
            players: {
              type: :object,
              properties: {
                id: {type: :integer},
                code: {type: :string},
                name: {type: :string}
              }
            }
          },
          required: ['players']

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { nil }
        run_test!
      end

      response '404', 'player not found' do
        let(:id) { 'invalid' }

        run_test!
      end
    end

    patch 'Updates a player' do
      let(:current_player) { create(:player, code: 'ABC123') }
      let(:Authorization) { "Bearer #{PlayerTokenService.new('ABC123').token}" }
      let(:player) { {name: 'Player 2', code: 'GHI789'} }
      let(:id) { current_player.id }

      before do
        current_player
      end

      tags 'Players'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :player, in: :body, schema: {
        type: :object,
        properties: {
          name: {type: :string}
        },
        required: ['name']
      }

      security [bearerAuth: []]

      response '200', 'player updated' do
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['players']['name']).to eq 'Player 2'
          expect(data['players']['code']).to eq 'ABC123'
        end
      end

      response '401', 'unauthorized when not updating self' do
        let(:id) { create(:player, name: 'Player 1').id }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { nil }

        run_test!
      end
    end
  end

end
