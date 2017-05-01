require 'savon'

module Northern911Api
  class Client
    attr_reader :configuration, :methods

    def initialize
      @configuration = Northern911Api.configuration
      @savon = savon_client
      @methods = savon_client.operations
    end

    def method_missing(method_name, *args, &block)
      if methods.include? method_name
        params = {}
        params = (args.first || {}).merge(hash: auth_string)
        params.merge!(vendor_code: configuration.vendor_code)
        # because savon do not support Customer object declared in WSDL as a complex type
        if(method_name == :addor_update_customer)
          raw_xml = "<SOAP-ENV:Envelope xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ns1='http://schemas.datacontract.org/2004/07/' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:ns2='http://tempuri.org/'><SOAP-ENV:Body><ns2:AddorUpdateCustomer><ns2:customer><ns1:CITY>#{params[:customer][:city]}</ns1:CITY><ns1:ENHANCED_CAPABLE>Y</ns1:ENHANCED_CAPABLE><ns1:FIRST_NAME>#{params[:customer][:first_name]}</ns1:FIRST_NAME><ns1:LAST_DATETIME_MODIFIED xsi:nil='true'/><ns1:LAST_DATETIME_MODIFIED_UNIXTIME xsi:nil='true'/><ns1:LAST_NAME>#{params[:customer][:last_name]}</ns1:LAST_NAME><ns1:OTHER_ADDRESS_INFO>#{params[:customer][:other_address_info]}</ns1:OTHER_ADDRESS_INFO><ns1:PHONE_NUMBER>#{params[:customer][:phone_number]}</ns1:PHONE_NUMBER><ns1:POSTAL_CODE_ZIP>#{params[:customer][:postal_code_zip]}</ns1:POSTAL_CODE_ZIP><ns1:PROVINCE_STATE>#{params[:customer][:province_state]}</ns1:PROVINCE_STATE><ns1:STREET_NAME>#{params[:customer][:street_name]}</ns1:STREET_NAME><ns1:STREET_NUMBER>#{params[:customer][:street_number]}</ns1:STREET_NUMBER><ns1:SUITE_APT>#{params[:customer][:suite_apt]}</ns1:SUITE_APT><ns1:VENDOR_CODE>#{configuration.vendor_code}</ns1:VENDOR_CODE></ns2:customer><ns2:hash>#{params[:hash]}</ns2:hash></ns2:AddorUpdateCustomer></SOAP-ENV:Body></SOAP-ENV:Envelope>"
          @savon.call(method_name, xml: raw_xml)
        elsif(method_name == :query_customer)
          raw_xml = "<SOAP-ENV:Envelope xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ns1='http://tempuri.org/'><SOAP-ENV:Body><ns1:QueryCustomer><ns1:vendorCode>#{configuration.vendor_code}</ns1:vendorCode><ns1:phoneNumber>#{params[:phone_number]}</ns1:phoneNumber><ns1:hash>#{params[:hash]}</ns1:hash></ns1:QueryCustomer></SOAP-ENV:Body></SOAP-ENV:Envelope>"
          @savon.call(method_name, xml: raw_xml)
        else
          @savon.call(method_name, message: params)
        end
      else
        raise NoMethodError, "#{method_name} is not a valid api endpoint!"
      end
    end

    private
    def savon_client
      Savon::Client.new wsdl: configuration.wsdl
    end

    def auth_string
      gmdate = Time.now.strftime('%Y%m%d')
      Digest::MD5.hexdigest(configuration.vendor_code + configuration.soap_passcode + gmdate)
    end
  end
end