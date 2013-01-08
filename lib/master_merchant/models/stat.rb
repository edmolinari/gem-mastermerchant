class MasterMerchant::Stat < MasterMerchant::Base
  include MasterMerchant::Connection

  def self.aggregate(metrics, options={})
    raise "You must supply :from, :to, or :(days|hours|minutes) to this query method." unless [:from, :to, :days, :hours, :minutes].any? {|k| options.has_key?(k) }
    raise "You must supply :operation to this query method." unless options[:operation]
    response = get(options.merge(:metrics => metrics))
    process_response(MasterMerchant::Stat, 'stats', response)
  end

  def self.find(metrics, options={})
    raise "You must supply :from, :to, or :(days|hours|minutes) to this query method." unless [:from, :to, :days, :hours, :minutes].any? {|k| options.has_key?(k) }
    raise "You must supply :by to this query method." unless options[:by]
    response = get(options.merge(:metrics => metrics))
    process_response(MasterMerchant::Stat, 'stats', response)
  end

  def self.member_url(options={})
    if options[:operation]
      uri = 'merchants/:merchant_id/stats/:metrics/:operation'
    else
      uri = 'merchants/:merchant_id/stats/:metrics/by/:by'
    end
    url = ":site_url/#{uri}.json"
    process_url(url, options)
  end

  def self.model_name
    'stat'
  end
end
