# frozen_string_literal: true

class ArgumentValidator
  attr_accessor :error_message

  MAX_FILE_SIZE = 1_073_741_824

  def initialize(file_path)
    @file_path = file_path
  end

  def call
    return false unless validate('File not found.') { File.exist?(@file_path) }
    return false unless validate('File is empty.') { !File.empty?(@file_path) }
    return false unless validate('File too big.') { File.size(@file_path) < MAX_FILE_SIZE }

    true
  end

  private

  def validate(message, &block)
    return true if block.call

    self.error_message = message
    false
  end
end
