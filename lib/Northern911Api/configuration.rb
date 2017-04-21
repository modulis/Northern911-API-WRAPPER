module Northern911Api
  class Configuration
    attr_accessor :vendor_code, :soap_passcode, :sandbox

    def initialize(params = {})
      @vendor_code = params[:vendor_code]
      @soap_passcode = params[:soap_passcode]
      @sandbox = params[:sandbox] || true
    end
  end
end