class MasterMerchant::Transfer < MasterMerchant::Base
  include MasterMerchant::Connection

  def self.collection_url(options={})
    url = ":site_url/merchants/:merchant_id/transfers.json"
    process_url(url, options)
  end

  def self.member_url(options={})
    url = ":site_url/merchants/:merchant_id/transfers/#{options[:id]}.json"
    process_url(url, options)
  end

  def self.model_name
    'transfer'
  end
end
