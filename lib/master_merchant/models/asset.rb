class MasterMerchant::Asset < MasterMerchant::Base
  extend MasterMerchant::Connection

  def collection_url(options={})
    url = ":site_url/merchants/:merchant_id/assets.json"
    process_url(url, options)
  end

  def member_url(options={})
    url = ":site_url/merchants/:merchant_id/assets/#{options[:id]}.json"
    process_url(url, options)
  end

  def to_param
    id
  end

  def model_name
    'asset'
  end
end
