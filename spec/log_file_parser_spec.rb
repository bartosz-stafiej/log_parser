# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LogFileParser do
  describe 'call' do
    subject(:call) { parser_instance.call }

    let(:parser_instance) { described_class.new('spec/fixtures/files/webserver_short.log') }
    let(:expected_overall_visits) do
      { '/help_page/1' => 7, '/contact' => 6, '/about/2' => 5, '/home' => 4, '/index' => 4, '/about' => 4 }
    end
    let(:expected_unique_visits) do
      {
        '/help_page/1' => {
          ips: ['126.318.035.038', '929.398.951.889', '722.247.931.582', '646.865.545.408', '543.910.244.929'],
          count: 5
        },
        '/contact' => {
          ips: ['184.123.665.067', '543.910.244.929', '555.576.836.194', '200.017.277.774',
                '316.433.849.805'], count: 5
        },
        '/home' => { ips: ['184.123.665.067', '235.313.352.950', '316.433.849.805', '444.701.448.104'],
                     count: 4 },
        '/about/2' => { ips: ['444.701.448.104', '836.973.694.403', '184.123.665.067', '382.335.626.855'],
                        count: 4 },
        '/index' => { ips: ['444.701.448.104', '316.433.849.805', '802.683.925.780', '929.398.951.889'],
                      count: 4 },
        '/about' => { ips: ['061.945.150.735', '126.318.035.038', '235.313.352.950', '836.973.694.403'],
                      count: 4 }
      }
    end

    it 'counts unique visits properly' do
      call
      expect(parser_instance.unique_visits).to eq(expected_unique_visits)
    end

    it 'counts overall visits properly' do
      call
      expect(parser_instance.visits_overall).to eq(expected_overall_visits)
    end
  end
end
