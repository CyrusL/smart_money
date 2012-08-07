class MoneyFieldMatcher
  def initialize(field_name)
    @expected_field_name = field_name
  end

  def matches?(subject)
    results = []
    subject.send "#{@expected_field_name}=", Money.new(2300)
    results << (subject.send(@expected_field_name) == Money.new(2300))
    results << (subject.send("#{@expected_field_name}_in_cents") == 2300)
    subject.send "#{@expected_field_name}=", "$23"
    results << (subject.send(@expected_field_name) == Money.new(2300))
    results << (subject.send("#{@expected_field_name}_in_cents") == 2300)
    subject.send "#{@expected_field_name}=", "$23"
    results << (subject.send(@expected_field_name).original_value == "$23")
    subject.send "#{@expected_field_name}=", nil
    results << (subject.send(@expected_field_name) == nil)

    return !results.include?(false)
  end

  def failure_message
    "Expected #{@expected_field_name} to be a money field"
  end

  def negative_failure_message
    "Didn't expect a money field for #{@expected_field_name}, \
     but got one anyway"
  end

  def description
    "use #{@expected_field_name} as a money field"
  end
end

def have_money_field(field_name)
  MoneyFieldMatcher.new(field_name)
end