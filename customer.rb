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

  def find_by_id(customer_id)
    if customer_id < @@next_customer_id
      File.open(File.dirname(__FILE__) + '/data/customer_table.txt', 'r') do |file|
        match = nil
        file.readlines.each do |line|
          matches = line.match(/(\d+) (\w+) (\w+) (\d{3}-\d{2}-\d{4}) "(.+)" (\[.+\])/)
          next unless matches.captures[0].to_i == customer_id

          match = matches.captures

          break
        end
        # puts match
        @this_customer_id = match[0].to_i
        @this_first_name = match[1]
        @this_last_name = match[2]
        @this_ssn = match[3]
        @this_address = match[4]
        @this_accounts = match[5].scan(/\d+/).map(&:to_i)
      end
    else
      puts 'Customer Not Found'
    end
  end

  def save
    
  end
end
c = Customer.new('Sam', 'Weinstein', '123-45-6789', '12345 Bruh Moment Drive, New York, New York')
