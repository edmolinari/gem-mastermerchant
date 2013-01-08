class MasterMerchant::Merchant < MasterMerchant::Base
  include MasterMerchant::Connection

  def self.collection_url(options={})
    url = ":site_url/merchants.json"
    process_url(url, options)
  end

  def self.member_url(options={})
    url = ":site_url/merchants/#{options[:id]}.json"
    process_url(url, options)
  end

  def self.model_name
    'merchant'
  end

  def to_param
    merchant_key
  end

  def partner
    (_v = super) && OpenStruct.new(_v) rescue nil
  end
  def verification_questions
    (_v = super) && OpenStruct.new(_v) rescue nil
  end
  def business_owners
    (_v = super) && OpenStruct.new(_v) rescue nil
  end

  def created_at
    Time.zone.parse(super)
  end
  def updated_at
    Time.zone.parse(super)
  end
end
