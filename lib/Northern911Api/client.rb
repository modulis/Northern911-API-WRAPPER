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
        @savon.call(method_name, message: params)
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