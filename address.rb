class Address
  attr_accessor :kind, :street_1, :street_2, :city, :postal_code

  def initialize(kind, city, postal_code, street_1, street_2=nil)
    @kind = kind
    @city = city
    @postal_code = postal_code
    @street_1 = street_1
    @street_2 = street_2
  end

  def to_s(format= "street_1")
   if format == "street_1"
     "#{kind}, #{street_1}, #{postal_code}"
   else
     "#{kind}, #{street_1}, #{street_2}, #{city}, #{postal_code}"
   end
  end
end