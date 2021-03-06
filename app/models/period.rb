class Period
  attr_reader :first, :last

  def self.month(date)
    new date.beginning_of_month, date.end_of_month
  end

  def initialize(first, last)
    @first = first
    @last = last
  end

  def to_s
    "#{first} - #{last}"
  end

  def month?
    first.present? &&
      first == first.beginning_of_month &&
      last == last.end_of_month &&
      last == first.end_of_month
  end
end
