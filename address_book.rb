require './contact.rb'
require 'yaml'

class AddressBook

  attr_accessor :contacts

  def initialize
    @contacts = []
    open()
  end

  def open
    if File.exist?("contacts.yml")
      @contacts = YAML.load_file("contacts.yml")
    end
  end

  def save
    File.open("contacts.yml", "w") do |file|
      file.write(contacts.to_yaml)
    end
  end

  def print_contact_list
    puts "Contact list"
    contacts.each {|contact| puts contact.to_s}
  end

  def find_by_name(name)
    results = []
    search = name.downcase
    contacts.each do |contact|
      if contact.full_name.downcase.include?(search)
        results.push(contact) unless results.include?(contact)
      end
    end
    print_results("Name search results (#{search})", results)
  end

  def find_by_phone_number(number)
    results = []
    #eliminates all the dashes
    search = number.gsub("-", "")
    contacts.each do |contact|
      contact.phone_numbers.each do |phone_number|
        if phone_number.number.gsub("-", "").include?(search)
          results.push(contact) unless results.include?(contact)
        end
      end
    end
    print_results("Phone search results (#{search})", results)
  end

  def find_by_address(address)
    results = []
    search = address.downcase
    contacts.each do |contact|
      contact.addresses.each do |address|
        if address.to_s.downcase.include?(search)
          results.push(contact) unless results.include?(contact)
        end
      end
    end
    print_results("Addresses search results (#{search})", results)
  end


  def print_results(search, results)
    puts search
    results.each do |contact|
      puts contact.to_s('full_name')
      contact.print_phone_numbers
      contact.print_addresses
      puts "\n"
    end
  end

  def display_help
    puts "type 'select all' to display all the contacts in the list"
    puts "type 'select name' to search a contact by name"
    puts "type 'select phone' to search a contact by phone number"
    puts "type 'select address' to search a contact by address"
    puts "type 'add' to add a contact"
    puts "type '-q' to exit the program"
  end

  def add_contact
    more = true
    while(more) do
      puts "Adding contact name....."
      puts "Enter a contact name"
      name = gets.chomp
      name = Contact.new
      puts "Enter first name: "
      f_name = gets.chomp
      name.first_name = f_name
      puts "Enter middle name: "
      m_name = gets.chomp
      name.middle_name = m_name
      puts "Enter last name: "
      l_name = gets.chomp
      name.last_name = l_name
      puts "Adding phone number...."
      puts "Enter phone location(Home, Work, etc.)"
      kind = gets.chomp
      puts "Enter phone number: "
      number = gets.chomp
      name.add_phone_number(kind, number)
      puts "Adding address...."
      puts "Enter address type (House, Flat, etc..)"
      type = gets.chomp
      puts "Enter city"
      city = gets.chomp
      puts "Enter postal code"
      p_code = gets.chomp
      puts "Enter street 1"
      street_1 = gets.chomp
      puts "Enter street 2"
      street_2 = gets.chomp
      name.add_address(type, city, p_code, street_1, street_2)
      contacts << name
      save()
      puts "Would you like to add more contacts. (enter y/n)"
      reply = gets.chomp
      if reply == 'n'
        more = false
      end
    end
  end

  def run
    quit = false
    while(!quit) do
      puts "What would you like to do? (type -h for help)"
      answer = gets.chomp.downcase
      case answer
        when '-h'
          display_help
        when 'select all'
          print_contact_list
        when 'select name'
          puts "enter a name"
          name = gets.chomp
          find_by_name(name)
        when 'select phone'
          puts "enter a phone number"
          phone = gets.chomp
          find_by_phone_number(phone)
        when 'select address'
          puts "enter an address"
          address = gets.chomp
          find_by_name(address)
        when 'add'
          add_contact
        when '-q'
          quit = true
          puts "Bye..."
        else
          puts "Sorry, command not recognized."
      end
    end
  end
end

