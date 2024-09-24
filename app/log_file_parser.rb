# frozen_string_literal: true

class LogFileParser
  attr_reader :visits_overall, :unique_visits

  def initialize(log_file_path)
    @log_file_path = log_file_path
    @visits_overall = {}
    @unique_visits = {}
  end

  def call
    File.open(@log_file_path, 'r').each_line do |line|
      endpoint, ip = line.split

      parse_overall_visits(endpoint)
      parse_unique_visits(endpoint, ip)
    end

    self
  end

  private

  def parse_overall_visits(endpoint)
    @visits_overall[endpoint] ||= 0
    @visits_overall[endpoint] += 1
  end

  def parse_unique_visits(endpoint, ip)
    @unique_visits[endpoint] ||= { ips: [], count: 0 }

    return if @unique_visits[endpoint][:ips].include?(ip)

    @unique_visits[endpoint][:ips] << ip
    @unique_visits[endpoint][:count] += 1
  end
end
