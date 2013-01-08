class MasterMerchant::Chargeback < MasterMerchant::Base
  include MasterMerchant::Connection

  def self.collection_url(options={})
    url = ":site_url/merchants/:merchant_id/chargebacks.json"
    process_url(url, options)
  end

  def self.member_url(options={})
    url = ":site_url/merchants/:merchant_id/chargeback/#{options[:id]}.json"
    process_url(url, options)
  end

  def self.model_name
    'chargeback'
  end
end
