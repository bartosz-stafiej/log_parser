# frozen_string_literal: true

class ResultLogger
  def initialize(unique_visits, visits_overall, logger)
    @logger = logger
    @unique_visits = unique_visits
    @visits_overall = visits_overall
  end

  def call
    @logger.info("Overall visits:\n")
    @visits_overall.each { |endpoint, visits| @logger.info("#{endpoint} #{visits} visits") }

    @logger.info("\n\nUnique visits:\n")

    @unique_visits.each { |endpoint, visits| @logger.info("#{endpoint} #{visits[:count]} unique visits") }
  end
end
