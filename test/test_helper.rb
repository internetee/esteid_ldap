# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'esteid_ldap'
require 'webmock/minitest'
require 'minitest/mock'

require 'minitest/autorun'
