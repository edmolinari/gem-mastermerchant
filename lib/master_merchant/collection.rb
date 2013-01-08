require 'ostruct'

class MasterMerchant::Collection < Array
  attr_reader :pagination

  def initialize(pagination = {}, results = [])
    @pagination = OpenStruct.new(pagination)
    self.push *results
  end
end
