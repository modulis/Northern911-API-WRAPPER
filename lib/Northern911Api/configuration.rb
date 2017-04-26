module Northern911Api
  class Configuration
    attr_accessor :vendor_code, :soap_passcode, :sandbox, :wsdl

    def initialize(params = {})
      @vendor_code = params[:vendor_code]
      @soap_passcode = params[:soap_passcode]
      @sandbox = params[:sandbox] || true
      @wsdl = @sandbox ? sandbox_url : live_url
    end

    def sandbox_url
      'https://soapdev.northern911.com/soap/Service.svc?wsdl'
    end

    def live_url
      'https://addressinfo.northern911.com/soap/Service.svc?wsdl'
    end
  end
end