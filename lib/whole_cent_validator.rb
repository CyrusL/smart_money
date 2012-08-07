class WholeCentValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?
    _, cents = value.original_value.to_s.gsub(/[^0-9.]/, '').split(".")
    begin
      if cents && (cents.length > 2) ||
        (value.original_value && Money.parse(value.original_value) == Money.new(0) && !value.original_value.to_s.gsub(/\$|\./, "").match(/^0+$/)) ||
        (value.original_value && !Money.parse(value.original_value).to_s.gsub(/\$|\.|,/, "").match(/#{value.original_value.to_s.gsub(/\$|\.|,/, "")}(00)?/))
        record.errors[attribute] << (options[:message] || "must be a valid dollar value")
      end
    rescue Money::Currency::UnknownCurrency
    end
  end
end
