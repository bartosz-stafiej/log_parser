# frozen_string_literal: true

# Specify the path to the 'app' directory relative to the current script
app_dir = File.expand_path('../app', __dir__)

require 'pry'
require 'logger'

# Iterate over all Ruby files in the 'app' directory and its subdirectories
Dir.glob("#{app_dir}/**/*.rb").sort.each { |file| require file }
