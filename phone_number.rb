class PhoneNumber
  attr_accessor :kind, :number

  def initialize(kind, number)
    @kind = kind
    @number = number
  end

  def to_s
    "#{kind}: #{number}"
  end
end