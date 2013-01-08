class MasterMerchant::Base
  include MasterMerchant::Connection
  attr_reader :messages, :errors, :attributes
  include ActiveModel::Dirty

  def initialize(attrs = {})
    @attributes = attrs
    @errors     = {}
    @messages   = []
    setup_attributes!
  end

  def replace(obj)
    attributes.replace(obj.attributes)
    errors.replace(obj.errors)
    messages.replace(obj.messages)
  end

  def setup_attributes!
    self.attributes.each do |key, _|
      self.class.define_attribute_method key
    end

    _attributes = self.attributes

    class_eval do
      _attributes.keys.each do |k|
        define_method(k) do
          return self.attributes[k]
        end

        define_method("#{k}=") do |val|
          send("#{k}_will_change!") unless val == self.attributes[k]
          self.attributes[k] = val
        end
      end
    end
  end

  def self.find(id, options={})
    response = get(options.merge(:id => id))
    process_response(self, model_name, response)
  end

  def self.all(options={})
    response = index(options)
    process_response(self, model_name.pluralize, response)
  end

  def save(options={})
    json = { self.class.model_name => attributes.select {|k, _| attribute_changed?(k) }}.to_json
    response = put(json, options.merge(:id => to_param))
    update_attributes_on_save && response.success?
  end

  def collection_url(options={})
    self.class.collection_url(options)
  end
  def member_url(options={})
    self.class.member_url(options)
  end
  def model_name
    self.class.model_name
  end
  def to_partial_path
    "#{model_name.pluralize}/#{model_name}"
  end
  def to_param
    id
  end

  def as_json(options = nil)
    self.attributes.as_json(options)
  end

  class_attribute :config
  self.config = MasterMerchant::Config.new

  protected

  def update_attributes_on_save
    @previously_changed = changes
    @changed_attributes.clear
  end
end
