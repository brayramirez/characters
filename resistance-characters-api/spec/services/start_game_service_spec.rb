require 'rails_helper'

describe StartGameService do

  let(:service) { StartGameService.new(game) }
  let(:game) { create(:game) }

  describe '#start_game' do

    context 'when minimum participants not met' do
      4.times do |index|
        let(:participants) {
          create_list(:participant, index + 1, game_id: game.id)
        }

        before do
          participants
          service.start_game
          game.reload
        end

        it { expect(game.status).to eq 'waiting' }
      end
    end

    context 'when minimum participants met' do
      6.times do |index|
        let(:number_of_opposition) {
          CharacterDistributionService::DISTRIBUTION[index + 5]
        }
        let(:participants) {
          create_list(:participant, index + 5, game_id: game.id)
        }

        before do
          participants
          service.start_game
          game.reload
        end

        it { expect(game.status).to eq 'in_progress' }
        it { expect(game.participants.oppositions.count).to eq number_of_opposition }
      end
    end

    context 'with characters selected' do
      let(:participants) { create_list(:participant, 10, game_id: game.id) }

      before do
        participants
        game.update(
          commander: true,
          bodyguard: true,
          false_commander: true,
          deep_cover: true,
          blind_spy: true
        )
        service.start_game

        game.reload
      end

      it { expect(game.status).to eq 'in_progress' }
      it { expect(game.participants.oppositions.count).to eq 4 }
      it 'expect to have commander' do
        commander = game.participants.where(character: :commander)

        expect(commander.count).to eq 1
        expect(commander.first.opposition).to eq false
      end
    end
  end

end
