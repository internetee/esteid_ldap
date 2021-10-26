# frozen_string_literal: true
require 'esteid_ldap/version'
require 'active_support'
require 'active_support/core_ext'
require 'net/ldap'
require 'json'

require_relative 'esteid_ldap/connector'

# This validator allows you to determine whether a citizen exists with a given isikukood or not.
#
# # The declaration looks like this:
# EsteidLdap::Search.new(host:, port:, ssl:, base:)
#
#
# Search values are assigned by default and they are specified in the module
# If necessary, you can reassign data such as host, port, ssl and base
#
# Method search_by_ident accept two parameters: code, with_data and in_json
# Code is private ident or "isikukood" and accept string type
# With_data is a boolean_type; If set false then results will be true or false
# If with_data is, then it returns data about citizen
# in_json - if set true, then if with_data - true, results returns in json
# otherwise results return in structure type

#
# ------------ Conntector ------------------
# Class name Connector accepts three parameters: hostname, port, and SSL method
# more information about Net::LDAP you can read here:
# https://www.rubydoc.info/github/ruby-ldap/ruby-net-ldap/Net%2FLDAP:search

module EsteidLdap
  BASE = 'c=EE'
  HOST_ADDRESS = 'esteid.ldap.sk.ee'
  PORT = '636'
  SSL_METHOD = :simple_tls

  Citizen = Struct.new(:dn, :objectclass, :cn, :serialNumber, :usercertificate_binary)

  class Search
    attr_reader :host, :ssl, :port, :connector, :base

    def initialize(host: HOST_ADDRESS, port: PORT, ssl: SSL_METHOD, base: BASE)
      @host = host
      @port = port
      @ssl = ssl
      @base = base
      @connector = connect_to_ldap
    end

    def search_by_ident(code:, with_data:, in_json:)
      search_filter = Net::LDAP::Filter.eq('serialNumber', "PNOEE-#{code}")
      result = @connector.search(base: @base, filter: search_filter, return_result: with_data)

      result

      # return false if result.blank? or result.nil? or result == []
      #
      # if in_json
      #   parse_result_to_json(result: result, with_data: with_data)
      # else
      #   parse_result_in_struct_object(result: result, with_data: with_data)
      # end
    end

    private

    def connect_to_ldap
       Connector.connect(@host, @port, @ssl)
    end

    def parse_result_to_json(result:, with_data:)
      return result unless with_data

      {
        'dn': result[0][:dn],
        'objectclass': result[0][:objectclass],
        'cn': result[0][:cn],
        'serialNumber': result[0][:serialNumber],
        "usercertificate;binary": result[0][:"usercertificate;binary"]
      }
    end

    def parse_result_in_struct_object(result:, with_data:)
      return result unless with_data

      Citizen.new(result[0][:dn], result[0][:objectclass], result[0][:cn], result[0][:serialNumber], result[0][:"usercertificate;binary"])
    end
  end
end
