class MasterMerchant::Config
  include MasterMerchant::Connection

  def initialize(options={})
    @site = options[:site_url] || 'https://payments-vip.snc1:8443/api'
    @typhoeus_options = {
      :verbose => false,
    }.merge(options[:typhoeus_options] || {})
    @typhoeus_options[:verbose] = true if @typhoeus_options[:debug]
  end

  def site_url
    @site
  end

  def typhoeus_options
    @typhoeus_options
  end
end
