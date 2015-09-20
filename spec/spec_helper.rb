$:.unshift File.expand_path('../lib/', File.dirname(__FILE__))
require 'rspec'
require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start

def read_from_enumerator(enumerator)
  result = []
  loop do
    begin
      result << enumerator.next
    rescue StopIteration
      break
    end
  end
  result
end