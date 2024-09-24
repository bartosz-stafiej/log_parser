# frozen_string_literal: true

class Script
  def initialize(file_path)
    @logger = Logger.new($stdout)
    @file_path = file_path
  end

  def run
    return unless run_validations

    result = LogFileParser.new(@file_path).call
    ordered_result = ResultSorter.new(result.unique_visits, result.visits_overall).call

    ResultLogger.new(ordered_result.unique_visits, ordered_result.visits_overall, @logger).call
  end

  def run_validations
    argument_validator = ArgumentValidator.new(@file_path)
    return true if argument_validator.call

    @logger.error(argument_validator.error_message)
    false
  end
end
