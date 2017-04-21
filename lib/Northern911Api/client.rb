require 'savon'

module Northern911Api
  class Client
    attr_reader :configuration, :methods

    def initialize
      @configuration = Northern911Api.configuration
      @savon = savon_client
      @methods = savon_client.soap_actions
    end

    def method_missing(method_name, *args, &block)
      if methods.include? method_name
        params = (args.first || {}).merge(auth_string: auth_string)
        #params.merge!(uniq_hash: (Time.now.to_i.to_s + auth_string)) if UNIQUE_HASH_METHODS.include?(method_name)
        @savon.call method_name, message: params
      else
        raise NoMethodError, "#{method_name} is not a valid api endpoint!"
      end
    end

    private

    def savon_client
      wsdl = configuration.sandbox ? sandbox_url : live_url
      Savon::Client.new wsdl: wsdl
    end

    def auth_string
      ### PHP code from online doc
      # $vendorCode = '955';
      # $soap_passcode = 'asdlfkj()*$JFU)SDf)SDuf';
      # $gmdate = gmdate('Ymd'); //YYYYMMDD
      # $hash = md5($vendorCode . $soap_passcode . $gmdate);
      gmdate = Time.now.strftime('%Y%m%d')
      Digest::MD5.hexdigest(configuration.vendor_code + configuration.soap_passcode + gmdate)
    end

    def sandbox_url
      'https://soapdev.northern911.com/soap/Service.svc?wsdl'
    end

    def live_url
      'https://addressinfo.northern911.com/soap/Service.svc?wsdl'
    end
  end
end