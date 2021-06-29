# frozen_string_literal: true

require 'esteid_ldap/version'
require 'active_support'
require 'active_support/core_ext'
require 'net/ldap'
# https://gist.github.com/jeffjohnson9046/7012167

module EsteidLdap
  class Error < StandardError; end

  class << self
    def connect
      Net::LDAP.new(host: 'esteid.ldap.sk.ee', port: 636, encryption: :simple_tls)
    end
  end
end
