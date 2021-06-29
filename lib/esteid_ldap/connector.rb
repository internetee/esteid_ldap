# frozen_string_literal: true

class Connector
  include EsteidLdap

  class << self
    def connect(host, port, ssl)
      Net::LDAP.new(host: host, port: port, encryption: ssl)
    end
  end
end
