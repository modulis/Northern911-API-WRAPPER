module Northern911Api
  class Configuration
    attr_accessor :auth_hash, :sandbox

    def initialize(params = {})
      vendor_code = params[:vendor_code]
      soap_passcode = params[:soap_passcode]
      gmdate = Time.now.strftime('%Y%m%d')
      @auth_hash = Digest::MD5.hexdigest(vendor_code + soap_passcode + gmdate)
      @sandbox = params[:sandbox] || true
    end
  end
end