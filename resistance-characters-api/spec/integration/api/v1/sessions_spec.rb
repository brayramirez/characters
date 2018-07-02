require 'swagger_helper'

describe 'Sessions API' do

  path '/api/v1/login' do
    post 'Login player' do
      let(:player) { create(:player, name: 'Player 1', code: 'ABC123') }

      tags 'Players'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :session, in: :body, schema: {
        type: :object,
        properties: {
          code: {type: :string}
        },
        required: ['code']
      }

      response '200', 'player logged in' do
        before do
          player
        end

        let(:session) { {session: {code: 'ABC123'}} }
        run_test! do |response|
          data = JSON.parse(response.body)

          expect(data['token']).not_to eq nil
          expect(data['name']).to eq 'Player 1'
          expect(data['code']).to eq 'ABC123'
        end
      end

      response '404', 'player not found' do
        let(:session) { {session: {code: 'invalid'}} }
        run_test!
      end
    end
  end

end
