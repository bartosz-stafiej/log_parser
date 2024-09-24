# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Script do
  describe 'run' do
    subject(:run) { described_class.new(file_path).run }

    let(:file_path) { 'example' }

    let(:dummy_validator) { instance_double(ArgumentValidator, call: true) }
    let(:dummy_parser) { instance_double(LogFileParser, unique_visits: [], visits_overall: []) }
    let(:dummy_sorter) { instance_double(ResultSorter, unique_visits: [], visits_overall: []) }
    let(:dummy_result_logger) { instance_double(ResultLogger) }

    let(:dummy_logger) { instance_double(Logger) }

    before do
      allow(LogFileParser).to receive(:new).and_return(dummy_parser)
      allow(ResultSorter).to receive(:new).and_return(dummy_sorter)
      allow(ResultLogger).to receive(:new).and_return(dummy_result_logger)

      allow(dummy_parser).to receive(:call).and_return(dummy_parser)
      allow(dummy_sorter).to receive(:call).and_return(dummy_sorter)
      allow(dummy_result_logger).to receive(:call)

      allow(ArgumentValidator).to receive(:new).and_return(dummy_validator)
      allow(Logger).to receive(:new).and_return(dummy_logger)
      allow(dummy_logger).to receive(:error)
    end

    it 'calls ArgumentValidator' do
      run
      expect(ArgumentValidator).to have_received(:new).with(file_path)
      expect(dummy_validator).to have_received(:call)
    end

    it 'calls LogFileParser' do
      run
      expect(LogFileParser).to have_received(:new).with(file_path)
      expect(dummy_parser).to have_received(:call)
    end

    it 'calls ResultSorter' do
      run
      expect(ResultSorter).to have_received(:new).with([], [])
      expect(dummy_sorter).to have_received(:call)
    end

    it 'calls ResultLogger' do
      run
      expect(ResultLogger).to have_received(:new).with([], [], dummy_logger)
      expect(dummy_result_logger).to have_received(:call)
    end

    it 'initializes Logger' do
      run
      expect(Logger).to have_received(:new).with($stdout)
    end

    context 'when validation fails' do
      let(:dummy_validator) { instance_double(ArgumentValidator, call: false, error_message: 'Example') }

      it 'calls ArgumentValidator' do
        run
        expect(ArgumentValidator).to have_received(:new).with(file_path)
      end

      it 'does not call LogFileParser' do
        run
        expect(LogFileParser).to_not have_received(:new)
      end

      it 'does not call ResultSorter' do
        run
        expect(ResultSorter).to_not have_received(:new)
      end

      it 'does not call ResultLogger' do
        run
        expect(ResultLogger).to_not have_received(:new)
      end

      it 'calls Logger' do
        run
        expect(dummy_logger).to have_received(:error).with('Example')
      end
    end
  end
end
