# frozen_string_literal: true

class Connector
  include EsteidLdap

  class << self
    def connect
      Net::LDAP.new(host: 'esteid.ldap.sk.ee', port: 636, encryption: :simple_tls)
    end
  end
end
