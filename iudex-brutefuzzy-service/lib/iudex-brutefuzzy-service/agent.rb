#--
# Copyright (c) 2011 David Kellum
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

require 'iudex-brutefuzzy-service'
require 'iudex-brutefuzzy-service/jms_qpid_context'
require 'iudex-brutefuzzy-service/destinations'

module Iudex::Brutefuzzy::Service

  class Agent
    include Iudex::Core
    include Iudex::Brutefuzzy

    def initialize
    end

    def run
      ctx = Iudex::JMSQpidContext.new

      Destinations.apply( ctx )

      Config.do_jms_context( ctx )

      fuzzy_tree = Iudex::SimHash::BruteFuzzy::FuzzyTree64.new( 500_000, 3, 16 )

      Config.do_fuzzy_tree( fuzzy_tree ) #FIXME: pointless

      svc = Service.new( fuzzy_tree, ctx )

      sleep #FIXME

    end

  end
end
