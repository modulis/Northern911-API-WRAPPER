require 'savon'

module Northern911Api
	class Customer
		attr_reader :configuration

		extend Savon::Model
		#client wsdl: "https://soapdev.northern911.com/soap/Service.svc?xsd=xsd2"
		#client wsdl: "https://soapdev.northern911.com/soap/Service.svc?wsdl"

	    def initialize(*operations)
	      @configuration = Northern911Api.configuration
	      self.class.client wsdl: configuration.wsdl
    	  operations.each { |operation| self.class.operations operation }
	    end
	  	
	  	operations :CITY, :CITY
	  	operations :ENHANCED_CAPABLE, :ENHANCED_CAPABLE
	  	operations :FIRST_NAME, :FIRST_NAME
	  	# operations :authenticate, :find_user
	  	# operations :authenticate, :find_user
	  	# operations :authenticate, :find_user
	  	# operations :authenticate, :find_user
	  	# operations :authenticate, :find_user
	  	# operations :authenticate, :find_user
	  	# operations :authenticate, :find_user
	  	# operations :authenticate, :find_user
	  	# operations :authenticate, :find_user
	  	# operations :authenticate, :find_user
	  	# operations :authenticate, :find_user
	end
end