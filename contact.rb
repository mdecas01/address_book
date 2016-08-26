require './phone_number'
require './address'

class Contact
  attr_writer :first_name, :middle_name, :last_name
  attr_reader :phone_numbers, :addresses

  def initialize
    @phone_numbers = []
    @addresses = []
  end

  def add_phone_number(kind, number)
    phone_number = PhoneNumber.new(kind, number)
    phone_numbers.push(phone_number)
  end

  def add_address(kind, city, postal_code, street_1, street_2=nil)
    address = Address.new(kind, city, postal_code, street_1, street_2)
    @addresses.push(address)
  end

  def print_phone_numbers
    puts "Phone numbers"
    phone_numbers.each { |pn| puts "#{pn.kind}: #{pn.number}" }
  end

  def print_addresses
    puts "#{full_name} addresses"
    @addresses.each do |address|
      if !address.street_2.nil?
        puts "#{address.kind}: #{address.street_1}, #{address.street_2}, #{address.city}, #{address.postal_code}"
      else
        puts "#{address.kind}: #{address.street_1}, #{address.city}, #{address.postal_code}"
      end
    end
  end


  def first_name
    @first_name
  end

  def middle_name
    @middle_name
  end

  def last_name
    @last_name
  end

  def first_last
    first_name + " " + last_name
  end

  def last_first
    full_name = last_name
    full_name += ', '
    full_name += first_name
    if !middle_name.nil?
      full_name += " "
      full_name += middle_name.slice(0, 2)
      full_name += '.'
    end
    full_name
  end

  def full_name
    full_name = first_name
    if !middle_name.nil?
      full_name += " "
      full_name += middle_name
    end
    full_name += " "
    full_name += last_name
    full_name
  end

  def to_s(format = 'full name')
   case format
     when 'full name'
       full_name
     when 'last first'
       last_first
     when 'first'
       first_name
     when 'last'
       last_name
     else
       first_last
   end
  end
end



