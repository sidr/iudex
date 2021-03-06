#!/usr/bin/env jruby
# -*- coding: utf-8 -*-
#.hashdot.profile += jruby-shortlived

#--
# Copyright (c) 2010 David Kellum
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
require 'iudex-html'

class TestOtherFilters < MiniTest::Unit::TestCase
  include HTMLTestHelper

  include Iudex::Core
  include Iudex::HTML
  include Iudex::HTML::Filters

  def test_title_extractor
    html = <<HTML
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <title>I&#363;dex</title>
  <style>style</style>
 </head>
 <body>
  <p>Iūdex test.</p>
 </body>
</html>
HTML

    map = content( html )
    chain = filter_chain( TitleExtractor.new )
    assert( chain.filter( map ) )
    assert_equal( 'Iūdex', map.title.to_s )
  end

end
