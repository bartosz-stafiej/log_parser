# frozen_string_literal: true

class ResultSorter
  attr_reader :visits_overall, :unique_visits

  def initialize(unique_visits, visits_overall)
    @visits_overall = visits_overall
    @unique_visits = unique_visits
  end

  def call
    sort_overall_visits
    sort_unique_visits
    self
  end

  private

  def sort_overall_visits
    @visits_overall = @visits_overall.sort_by { |_endpoint, visits_count| -visits_count }.to_h
  end

  def sort_unique_visits
    @unique_visits = @unique_visits.sort_by { |_endpoint, visits| -visits[:count] }.to_h
  end
end
