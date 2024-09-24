# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ArgumentValidator do
  describe '#call' do
    subject(:instance_call) { validator_instance.call }

    let(:validator_instance) { described_class.new(file_path) }

    context 'when file is valid' do
      let(:file_path) { 'spec/fixtures/files/webserver_short.log' }

      it { is_expected.to be_truthy }

      it 'has empty error_message' do
        instance_call
        expect(validator_instance.error_message).to be_nil
      end
    end

    context 'when file does not exist' do
      let(:file_path) { 'invalid' }

      it { is_expected.to be_falsey }

      it 'has proper error_message' do
        instance_call
        expect(validator_instance.error_message).to eq('File not found.')
      end
    end

    context 'when file is empty' do
      let(:file_path) { 'spec/fixtures/files/empty_webserver.log' }

      it { is_expected.to be_falsey }

      it 'has proper error_message' do
        instance_call
        expect(validator_instance.error_message).to eq('File is empty.')
      end
    end

    context 'when file is too big' do
      let(:file_path) { 'some' }

      # Mock instead of include huge file in fixtures
      before do
        allow(File).to receive(:exist?).and_return(true)
        allow(File).to receive(:zero?).and_return(false)
        allow(File).to receive(:size).and_return(1_073_741_825)
      end

      it { is_expected.to be_falsey }

      it 'has proper error_message' do
        instance_call
        expect(validator_instance.error_message).to eq('File too big.')
      end
    end
  end
end
