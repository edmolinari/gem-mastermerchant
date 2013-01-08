class MasterMerchant::Merchant < MasterMerchant::Base
  include MasterMerchant::Connection

  def self.collection_url(options={})
    if options[:sources]
      uri = 'merchants/from_data_sources'
    elsif options[:credentials]
      uri = 'merchants/check_credentials'
    else
      uri = 'merchants'
    end
    url = ":site_url/#{uri}.json"
    process_url(url, options)
  end

  def self.member_url(options={})
    if options[:locate_identity]
      uri = '/locate_identity'
    else
      uri = ''
    end
    url = ":site_url/merchants/#{options[:id]}#{uri}.json"
    process_url(url, options)
  end

  def from_data_sources(options={})
    raise "You must supply :sources to this query method." unless options[:sources]
    index(options)
  end

  def check_credentials(options={})
    raise "You must supply :credentials to this query method." unless options[:credentials]
    index(options)
  end

  def locate_identity(options={})
    get(options.merge(:locate_identity => true))
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
