#!/usr/bin/env ruby
# frozen_string_literal: true

require 'weneedfeed'

module Weneedfeed
  class Item
    class << self
      # @param [String] string
      # @return [Time, nil]
      def parse_time(string)
        ::Time.strptime(string, "●%Y年 %m月 %d日更新分")
      rescue ::ArgumentError
        begin
          time = ::Time.strptime(string, '%m月%d日')
          time -= 60 * 60 * 24 * 365 if time > Time.now
          time
        rescue ArgumentError
          begin
            ::Time.parse(string)
          rescue ArgumentError, RangeError
          end
        end
      end
    end
  end
end

Weneedfeed::Command.start(ARGV)
