require 'rails_helper'

describe MinimumParticipantsRuleService do

  describe '#minimum_participants_met?' do
    let(:service) { MinimumParticipantsRuleService.new(game) }
    let(:game) { create(:game) }

    before do
      game
    end

    context 'when number of participants is less than 5' do
      4.times do |index|
        let(:participants) {
          create_list(:participant, index + 1, game_id: game.id)
        }

        before do
          participants
        end

        it { expect(service.minimum_participants_met?).to eq false }
      end
    end

    context 'when number of participants is 5 or more' do
      6.times do |index|
        let(:participants) {
          create_list(:participant, index + 5, game_id: game.id)
        }

        before do
          participants
        end

        it { expect(service.minimum_participants_met?).to eq true }
      end
    end
  end

end
