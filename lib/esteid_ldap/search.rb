class Search
  include EsteidLdap

	BASE = 'c=EE'.freeze

	def initialize
		@connector = EsteidLdap.connect
	end

  def search(code)
    search_filter = Net::LDAP::Filter.eq('serialNumber', "PNOEE-#{code}")

    @connector.search(base: BASE, filter: search_filter, return_result: true).present?
  end
end
