class MasterMerchant::BankAccount < MasterMerchant::Base
  include MasterMerchant::Connection

  def self.collection_url(options={})
    url = ":site_url/merchants/:merchant_id/bank_accounts.json"
    process_url(url, options)
  end

  def self.member_url(options={})
    url = ":site_url/merchants/:merchant_id/bank_accounts/#{options[:id]}.json"
    process_url(url, options)
  end

  def self.model_name
    'bank_account'
  end
end
