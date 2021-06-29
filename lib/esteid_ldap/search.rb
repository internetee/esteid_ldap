# frozen_string_literal: true

require_relative 'connector'

class Search
  include EsteidLdap

  BASE = 'c=EE'

  class << self
    def search(code)
      @connector ||= Connector.connect
      search_filter = Net::LDAP::Filter.eq('serialNumber', "PNOEE-#{code}")

      @connector.search(base: BASE, filter: search_filter, return_result: true).present?
    end
  end
end
