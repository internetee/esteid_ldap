# frozen_string_literal: true

require 'esteid_ldap/version'
require 'active_support'
require 'active_support/core_ext'
require 'net/ldap'

module EsteidLdap
  class Error < StandardError; end
end
