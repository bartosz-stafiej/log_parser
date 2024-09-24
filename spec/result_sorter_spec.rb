# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResultSorter do
  describe '#call' do
    subject(:call) { sorter_instance.call }

    let(:sorter_instance) { described_class.new(unique_visits, visits_overall) }

    let(:unique_visits) { { 'second' => { count: 20 }, 'third' => { count: 30 }, 'first' => { count: 10 } } }
    let(:visits_overall) { { 'sixth' => 60, 'fifth' => 50, 'fourth' => 40 } }

    it 'sorts unique visits' do
      call
      expect(sorter_instance.unique_visits).to eq({ 'first' => { count: 10 }, 'second' => { count: 20 },
                                                    'third' => { count: 30 } })
    end

    it 'sorts overall visits' do
      call
      expect(sorter_instance.visits_overall).to eq({ 'fourth' => 40, 'fifth' => 50, 'sixth' => 60 })
    end
  end
end
