require 'rails_helper'

describe SelectedCharactersRulesService do

  let(:service) { SelectedCharactersRulesService.new(game) }

  describe '#valid?' do
    # {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: false, commander: false}
    # {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: false, commander: true}
    # {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: true, commander: false}
    # {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: true, commander: true}
    # {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: false, commander: false}
    # {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: false, commander: true}
    # {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: true, commander: false}
    # {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: true, commander: true}
    # {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: false, commander: false}
    # {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: false, commander: true}
    # {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: true, commander: false}
    # {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: true, commander: true}
    # {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: false, commander: false}
    # {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: false, commander: true}
    # {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: true, commander: false}
    # {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: true, commander: true}
    # {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: false, commander: false}
    # {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: false, commander: true}
    # {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: true, commander: false}
    # {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: true, commander: true}
    # {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: false, commander: false}
    # {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: false, commander: true}
    # {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: true, commander: false}
    # {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: true, commander: true}
    # {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: false, commander: false}
    # {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: false, commander: true}
    # {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: true, commander: false}
    # {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: true, commander: true}
    # {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: false, commander: false}
    # {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: false, commander: true}
    # {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: true, commander: false}
    # {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: true, commander: true}

    let(:participants) {
      create_list(:participant, number_of_players, game_id: game.id)
    }

    context 'with 5 players' do
      let(:number_of_players) { 5 }

      valid_combination =
        [
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: true, commander: true}
        ]

      invalid_combination =
        [
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: true, commander: true}
        ]

      context 'with valid combination' do
        valid_combination.each do |attr|
          let(:game) { create(:game, attr) }

          before do
            game
            participants
          end

          it { expect(service.valid?).to eq true }
        end
      end

      context 'with invalid combination' do
        invalid_combination.each do |attr|
          let(:game) { create(:game, attr) }

          before do
            game
            participants
          end

          it { expect(service.valid?).to eq false }
        end
      end
    end

    context 'with 6 players' do
      let(:number_of_players) { 6 }

      valid_combination =
        [
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: true, commander: true}
        ]

      invalid_combination =
        [
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: true, commander: true}
        ]

      context 'with valid combination' do
        valid_combination.each do |attr|
          let(:game) { create(:game, attr) }

          before do
            game
            participants
          end

          it { expect(service.valid?).to eq true }
        end
      end

      context 'with invalid combination' do
        invalid_combination.each do |attr|
          let(:game) { create(:game, attr) }

          before do
            game
            participants
          end

          it { expect(service.valid?).to eq false }
        end
      end
    end

    context 'with 7 players' do
      let(:number_of_players) { 7 }

      valid_combination =
        [
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: true, commander: false},
        ]

      invalid_combination =
        [
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: true, commander: true}
        ]

      context 'with valid combination' do
        valid_combination.each do |attr|
          let(:game) { create(:game, attr) }

          before do
            game
            participants
          end

          it { expect(service.valid?).to eq true }
        end
      end

      context 'with invalid combination' do
        invalid_combination.each do |attr|
          let(:game) { create(:game, attr) }

          before do
            game
            participants
          end

          it { expect(service.valid?).to eq false }
        end
      end
    end

    context 'with 8 players' do
      let(:number_of_players) { 8 }

      valid_combination =
        [
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: true, commander: false},
        ]

      invalid_combination =
        [
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: true, commander: true}
        ]

      context 'with valid combination' do
        valid_combination.each do |attr|
          let(:game) { create(:game, attr) }

          before do
            game
            participants
          end

          it { expect(service.valid?).to eq true }
        end
      end

      context 'with invalid combination' do
        invalid_combination.each do |attr|
          let(:game) { create(:game, attr) }

          before do
            game
            participants
          end

          it { expect(service.valid?).to eq false }
        end
      end
    end

    context 'with 9 players' do
      let(:number_of_players) { 9 }

      valid_combination =
        [
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: true, commander: false},
        ]

      invalid_combination =
        [
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: true, commander: true}
        ]

      context 'with valid combination' do
        valid_combination.each do |attr|
          let(:game) { create(:game, attr) }

          before do
            game
            participants
          end

          it { expect(service.valid?).to eq true }
        end
      end

      context 'with invalid combination' do
        invalid_combination.each do |attr|
          let(:game) { create(:game, attr) }

          before do
            game
            participants
          end

          it { expect(service.valid?).to eq false }
        end
      end
    end

    context 'with 10 players' do
      let(:number_of_players) { 10 }

      valid_combination =
        [
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: false, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: false, blind_spy: true, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: false, false_commander: true, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: false, bodyguard: true, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: false, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: false, commander: true},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: true, commander: false},
          {deep_cover: true, blind_spy: true, false_commander: true, bodyguard: true, commander: true}
        ]

      invalid_combination = []

      context 'with valid combination' do
        valid_combination.each do |attr|
          let(:game) { create(:game, attr) }

          before do
            game
            participants
          end

          it { expect(service.valid?).to eq true }
        end
      end

      context 'with invalid combination' do
        invalid_combination.each do |attr|
          let(:game) { create(:game, attr) }

          before do
            game
            participants
          end

          it { expect(service.valid?).to eq false }
        end
      end
    end
  end

end
