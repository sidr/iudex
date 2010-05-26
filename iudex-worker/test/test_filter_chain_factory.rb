#!/usr/bin/env jruby
#.hashdot.profile += jruby-shortlived

#--
# Copyright (c) 2008-2010 David Kellum
#
# Licensed under the Apache License, Version 2.0 (the "License"); you
# may not use this file except in compliance with the License.  You
# may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.  See the License for the specific language governing
# permissions and limitations under the License.
#++

require File.join( File.dirname( __FILE__ ), "setup" )

RJack::Logback.config_console( :stderr => true, :mdc => "uhash" )

require 'iudex-worker'
require 'iudex-worker/filter_chain_factory'

class TestFilterChainFactory < MiniTest::Unit::TestCase
  include Iudex::Core
  include Iudex::Worker
  include Gravitext::HTMap

  import 'iudex.core.ContentKeys'
  import 'iudex.core.VisitURL'
  UniMap.define_accessors #FIXME: FilterFactory after all filters created?

  def test_filter
    fcf = FilterChainFactory.new( "test" )
    fcf.add_summary_reporter
    fcf.add_by_filter_reporter

    def fcf.additional_writer_fields
      super + [ ContentKeys::TITLE ]
    end

    fcf.filter do |chain|
      # Run twice (assume new the first time, updates the second).
      2.times do
        content = UniMap.new
        content.url = VisitURL.normalize( "http://gravitext.com/atom.xml" )
        content.type = "FEED"
        content.priority = 1.0
        assert( chain.filter( content ) )
      end
    end

  end

end
