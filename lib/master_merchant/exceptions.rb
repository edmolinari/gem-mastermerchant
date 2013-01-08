module MasterMerchant
  class Exception < StandardError
    attr_reader :response
    def initialize(_response)
      @response = _response
    end
  end
  class ResourceNotFound < MasterMerchant::Exception; end
  class BadRequest < MasterMerchant::Exception; end
  class ParseError < MasterMerchant::Exception
    attr_reader :original_exception
    def initialize(_response, _orig)
      @response = _response
      @original_exception = _orig
    end
  end
end
