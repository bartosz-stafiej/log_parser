# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResultLogger do
  describe '#call' do
    subject(:call) { described_class.new(unique_visits, visits_overall, logger).call }

    let(:logger) { instance_double(Logger) }
    let(:visits_overall) { { 'first_endpoint' => 10, 'second_endpoint' => 20 } }
    let(:unique_visits) { { 'third_endpoint' => { count: 30 }, 'fourth_endpoint' => { count: 40 } } }

    before { allow(logger).to receive(:info) }

    it 'loggs proper strings' do
      call
      expect(logger).to have_received(:info).exactly(6).times
      expect(logger).to have_received(:info).with("Overall visits:\n")
      expect(logger).to have_received(:info).with('first_endpoint 10 visits')
      expect(logger).to have_received(:info).with('second_endpoint 20 visits')

      expect(logger).to have_received(:info).with("\n\nUnique visits:\n")
      expect(logger).to have_received(:info).with('third_endpoint 30 unique visits')
      expect(logger).to have_received(:info).with('fourth_endpoint 40 unique visits')
    end
  end
end
