# frozen_string_literal: true

class Customer
  File.open(File.dirname(__FILE__) + '/data/customer_table.txt', 'r') do |file|
    file.readlines.each  do |line|
      @@next_customer_id = line.match(/(\d+)/)[0].to_i + 1
    end
  end

  def initialize(first_name = nil, last_name = nil, ssn = nil, address = nil)
    @this_first_name = first_name
    @this_last_name = last_name
    @this_ssn = ssn
    @this_address = address
    @this_customer_id = @@next_customer_id
    @@next_customer_id += 1
    @this_accounts = []
  end

  def retrieve_data(customer_id)
    file = File.open(File.dirname(__FILE__) + '/data/customer_table.txt', 'r')
    if customer_id < @@next_customer_id
      match = nil
      file.readlines.each do |line|
        matches = line.match(/(\d+) (\w+) (\w+) (\d{3}-\d{2}-\d{4}) "(.+)" (\[.+\])/)
        next unless matches.captures[0].to_i == customer_id

        return {
          "matches" => matches.captures,
          "file" => file
        }
      end
    else
      return {
        "matches" => false,
        "file" => file
      }
    end
  end

  def find_by_id(customer_id)
    data = retrieve_data(customer_id)
    data['file'].close
    customer_data = data['matches']

    if customer_data != false
      # puts match
      @this_customer_id = customer_data[0].to_i
      @this_first_name = customer_data[1]
      @this_last_name = customer_data[2]
      @this_ssn = customer_data[3]
      @this_address = customer_data[4]
      @this_accounts = customer_data[5].scan(/\d+/).map(&:to_i)
    else
      puts 'Customer Not Found'
    end
  end
  def save
    customer_data = retrieve_data(@this_customer_id)
    if customer_data
      puts customer_data['file']
    end
  end

end
# c = Customer.new('Sam', 'Weinstein', '123-45-6789', '12345 Bruh Moment Drive, New York, New York')
d = Customer.new
d.find_by_id(1)
d.save
