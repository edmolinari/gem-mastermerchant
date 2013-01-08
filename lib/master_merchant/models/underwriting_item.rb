class MasterMerchant::UnderwritingItem < MasterMerchant::Base
  include MasterMerchant::Connection

  def self.collection_url(options={})
    url = ":site_url/merchants/:merchant_id/underwriting_items.json"
    process_url(url, options)
  end

  def self.member_url(options={})
    url = ":site_url/merchants/:merchant_id/underwriting_items/#{options[:id]}.json"
    process_url(url, options)
  end

  def self.model_name
    'underwriting_item'
  end
end
