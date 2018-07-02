require 'swagger_helper'

describe 'Games API' do

  let(:current_player) { create(:player, code: 'ABC123') }
  let(:Authorization) { "Bearer #{PlayerTokenService.new('ABC123').token}" }

  path '/api/v1/games' do
    post 'Create a game' do
      let(:game) { {game: {name: 'New Game'}} }

      before do
        current_player
      end

      tags 'Games'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :game, in: :body, schema: {
        type: :object,
        properties: {
          name: {type: :string}
        },
        required: ['name']
      }
      security [bearerAuth: []]

      response '200', 'game created' do
        run_test! do |response|
          data = JSON.parse(response.body)

          expect(data['games']['name']).to eq 'New Game'
          expect(data['games']['code']).not_to eq nil
          expect(data['games']['status']).to eq 'waiting'
          expect(data['games']['commander']).to eq false
          expect(data['games']['false_commander']).to eq false
          expect(data['games']['bodyguard']).to eq false
          expect(data['games']['blind_spy']).to eq false
          expect(data['games']['deep_cover']).to eq false
          expect(data['games']['host_id']).to eq current_player.id
          expect(data['games']['is_owner']).to eq true
          expect(Participant.count).to eq 1
        end
      end

      response '401', 'unauthorized' do
        let(:Authorization) { nil }
        run_test!
      end
    end
  end

  path '/api/v1/games/{id}' do
    get 'Retrieves a game' do
      let(:id) { create(:game).id }

      before do
        current_player
      end

      tags 'Games'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      security [bearerAuth: []]

      response '200', 'game found' do
        schema type: :object,
          properties: {
            games: {
              type: :object,
              properties: {
                id: {type: :integer},
                code: {type: :string},
                name: {type: :string},
                status: {type: :string},
                commander: {type: :boolean},
                false_commander: {type: :boolean},
                bodyguard: {type: :boolean},
                blind_spy: {type: :boolean},
                deep_cover: {type: :boolean},
                host_id: {type: :integer},
                is_owner: {type: :boolean}
              }
            }
          },
          required: ['games']

        run_test! do |response|
          data = JSON.parse(response.body)

          expect(data['games']['is_owner']).to eq false
        end
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

    patch 'Updates a game' do
      let(:current_game) {
        create(:game, code: 'ABC123', host_id: current_player.id)
      }
      let(:game) { {
          name: 'Game 2',
          code: 'GHI789',
          commander: true,
          false_commander: true,
          bodyguard: true,
          blind_spy: true,
          deep_cover: true
        }
      }
      let(:id) { current_game.id }

      before do
        current_player
        current_game
      end

      tags 'Games'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :game, in: :body, schema: {
        type: :object,
        properties: {
          name: {type: :string},
          commander: {type: :boolean},
          false_commander: {type: :boolean},
          bodyguard: {type: :boolean},
          blind_spy: {type: :boolean},
          deep_cover: {type: :boolean}
        },
        required: [
          'name',
          'commander',
          'false_commander',
          'bodyguard',
          'blind_spy',
          'deep_cover'
        ]
      }

      security [bearerAuth: []]

      response '200', 'player updated' do
        run_test! do |response|
          data = JSON.parse(response.body)

          expect(data['games']['name']).to eq 'Game 2'
          expect(data['games']['code']).to eq 'ABC123'
          expect(data['games']['status']).to eq 'waiting'
          expect(data['games']['commander']).to eq true
          expect(data['games']['false_commander']).to eq true
          expect(data['games']['bodyguard']).to eq true
          expect(data['games']['blind_spy']).to eq true
          expect(data['games']['deep_cover']).to eq true
        end
      end

      response '401', 'unauthorized when updating not hosted game' do
        let(:id) { create(:game, name: 'Game 1').id }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { nil }

        run_test!
      end
    end
  end

  path '/api/v1/games/{id}/start' do
    put 'Starts a game' do
      let(:current_game) {
        create(:game, code: 'ABC123', host_id: current_player.id)
      }
      let(:id) { current_game.id }
      let(:participant) {
        create(:participant, game_id: id, player_id: current_player.id)
      }

      before do
        current_player
        current_game
        participant
      end

      tags 'Games'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      security [bearerAuth: []]

      response '200', 'game updated' do
        let(:participants) { create_list(:participant, 4, game_id: id) }

        before do
          participants
        end

        run_test! do |response|
          data = JSON.parse(response.body)

          expect(data['games']['status']).to eq 'in_progress'
        end
      end

      response '422', 'minimum number of players not met' do
        run_test!
      end

      response '401', 'unauthorized when updating not hosted game' do
        let(:id) { create(:game, name: 'Game 1').id }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { nil }

        run_test!
      end
    end
  end

  path '/api/v1/games/{id}/end' do
    put 'Ends a game' do
      let(:current_game) {
        create(:game, code: 'ABC123', host_id: current_player.id)
      }
      let(:id) { current_game.id }

      before do
        current_player
        current_game
      end

      tags 'Games'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      security [bearerAuth: []]

      response '200', 'game updated' do
        run_test! do |response|
          data = JSON.parse(response.body)

          expect(data['games']['status']).to eq 'complete'
        end
      end

      response '401', 'unauthorized when updating not hosted game' do
        let(:id) { create(:game, name: 'Game 1').id }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { nil }

        run_test!
      end
    end
  end

  path '/api/v1/games/{id}/join' do
    post 'Join current signed in player' do
      let(:current_game) {
        create(:game, code: 'ABC123', host_id: current_player.id)
      }
      let(:id) { current_game.id }

      before do
        current_player
        current_game
      end

      tags 'Games'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      security [bearerAuth: []]

      response '200', 'player already joined' do
        let(:current_participant) {
          create(:participant, game_id: id, player_id: current_player.id)
        }

        before do
          current_participant
        end

        run_test! do |response|
          expect(Participant.count).to eq 1
        end
      end

      response '200', 'player joined' do
        let(:participant) {
          create(
            :participant,
            game_id: current_game.id
          )
        }

        before do
          participant
        end

        run_test! do |response|
          expect(Participant.count).to eq 2
        end
      end

      response '422', 'maximum players reached' do
        let(:participants) { create_list(:participant, 10, game_id: id) }

        before do
          participants
        end

        run_test!
      end
    end
  end

  path '/api/v1/games/{id}/disconnect' do
    delete 'Player disconnected from game' do
      let(:current_game) {
        create(:game, code: 'ABC123', host_id: current_player.id)
      }
      let(:id) { current_game.id }

      before do
        current_player
        current_game
      end

      tags 'Games'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      security [bearerAuth: []]

      response '200', 'player disconnected' do
        let(:participant) {
          create(:participant, game_id: id, player_id: current_player.id)
        }

        before do
          participant
        end

        run_test! do |response|
          expect(Participant.count).to eq 0
        end
      end

      response '200', 'player not connected in the first place' do
        run_test! do |response|
          expect(Participant.count).to eq 0
        end
      end
    end
  end
end
