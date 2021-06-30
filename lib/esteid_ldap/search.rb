# frozen_string_literal: true

require_relative 'connector'
require 'json'

class Search
  include EsteidLdap

  BASE = 'c=EE'

  class << self
    def search(connector, code, with_data)
      search_filter = Net::LDAP::Filter.eq('serialNumber', "PNOEE-#{code}")

      return connector.search(base: BASE, filter: search_filter).present? unless with_data

      result = connector.search(base: BASE, filter: search_filter, return_result: true)

      return false if result == [] || result.nil?

      parse_result_to_json(result)
    end

    private

    def parse_result_to_json(result)
      json = {}

      {
        'dn': result[0][:dn],
        'objectclass': result[0][:objectclass],
        'cn': result[0][:cn],
        'serialNumber': result[0][:serialNumber],
        "usercertificate;binary": result[0][:"usercertificate;binary"]
      }
    end
  end
end
