# frozen_string_literal: true

require 'test_helper'

class EsteidLdapTest < ActiveSupport::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::EsteidLdap::VERSION
  end

  def test_search_existing_ident_code
    ident = Search.new
    assert ident.search('38903110313')
  end

	def test_search_non_existing_ident_code
    ident = Search.new
    assert_not ident.search('2222222')
  end
end
