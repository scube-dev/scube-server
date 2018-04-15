class Form
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  # NOTE: we must extend with `Forwardable' after `ActiveModel::Naming' since
  # rails >= 4.2.4 (10adc2ee) broke standard `Forwardable' behavior.
  # Extending a class with ActiveModel::Naming will call `.delegate' and expect
  # a modified ActiveSupport version, which has different arity and behavior
  # than the standard method.
  extend Forwardable

  class << self
    def delegate_attributes attrs
      def_delegators :@record, *attrs
    end

    def resource res
      define_singleton_method(:attached_resource) { res }
    end
  end

  def_delegators :@record, :id, :new_record?, :persisted?

  attr_reader :record

  def initialize attributes = {}, record: self.class.attached_resource.new
    @record = record
    define_model_name
    attributes.each do |k, v|
      meth = "#{k}="
      recipient = respond_to?(meth) ? self : record
      recipient.send meth, v
    end
    setup if respond_to? :setup
  end

  def == other
    record == other.record
  end

  def save
    if valid? && record.valid?
      record.save
    else
      record.valid?
      merge_errors and false
    end
  end

private

  def define_model_name
    self.class.define_singleton_method :model_name do
      ActiveModel::Name.new attached_resource
    end
  end

  def merge_errors
    record.errors.each { |k, v| errors[k] = v }
  end
end
