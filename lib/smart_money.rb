require 'money'
require 'whole_cent_validator'
require 'rspec_matchers/money_field_matcher' if Rails.env.test?

Money.class_eval do
  attr_accessor :original_value
end

module SmartMoney

  def smart_money(column)
    composed_of column,
                :class_name => "Money",
                :mapping => ["#{column}_in_cents", "cents"],
                :converter => proc { |value|
                  money = value.to_s.gsub(/[^\d|\.|-]/, '').to_money
                  money.original_value = value
                  money
                },
                :allow_nil => true

    validates column, :whole_cent => {:message => "must be a valid dollar amount."}
  end

end