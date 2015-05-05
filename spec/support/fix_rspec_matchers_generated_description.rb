module RSpec
  module Matchers
    def self.generated_description
      return nil if last_expectation_handler.nil?
      "must #{last_description}"
    end
  end
end
