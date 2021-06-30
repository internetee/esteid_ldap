# frozen_string_literal: true

require 'esteid_ldap/version'
require 'active_support'
require 'active_support/core_ext'
require 'net/ldap'

require_relative 'esteid_ldap/connector'

module EsteidLdap
  class Error < StandardError; end

  class << self
    def search_by_ident(code, with_data)
      connect_to_ldap
      Search.search(@connector, code, with_data)
    end

    private

    def connect_to_ldap
      @connector = Connector.connect('esteid.ldap.sk.ee', 636, :simple_tls)
    end
  end
end
