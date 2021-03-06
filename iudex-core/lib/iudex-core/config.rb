#--
# Copyright (c) 2008-2010 David Kellum
#
# Licensed under the Apache License, Version 2.0 (the "License"); you
# may not use this file except in compliance with the License.  You may
# obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.  See the License for the specific language governing
# permissions and limitations under the License.
#++

require 'rjack-slf4j'
require 'optparse'

module Iudex

  # Yield Iudex::Core::Config module to block
  def self.configure
    yield Iudex::Core::Config
  end

  module Core

    # Extensible module defining top level configuration blocks.
    module Config

      @log = RJack::SLF4J[ self ]

      # Parse options using an OptionParser, defining (-c)onfig
      # option, and yielding to block for further option handling.
      def self.parse_options( args = ARGV, &block )
        parser = OptionParser.new do |opts|
          opts.on( "-c", "--config FILE", "Load configuration file") do |file|
            load_config( file )
          end
          block.call( opts ) if block
        end
        parser.parse!
      end

      # Load a configuration file (with info log message)
      def self.load_config( file )
        @log.info "Loading config #{file}."
        load file
      end

      # Ignore undefined configuration blocks (with a debug log message).
      def self.method_missing( method, *arguments, &block )
        ccall = caller[0]
        @log.debug do
          "Method %s from %s not defined, ignored" % [ method, ccall ]
        end
      end
    end
  end
end
