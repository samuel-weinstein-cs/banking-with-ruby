class Customer
  File.open(File.dirname(__FILE__)+'/data/customer_table.txt','r') do |file|
    file.readlines.each  do |line|
      @@next_customer_id = line.match(/(\d+)/)[0].to_i + 1
    end
    puts @@next_customer_id
  end
  def initialize(first_name, last_name, ssn, address)
    @this_first_name = first_name
    @this_last_name = last_name
    @this_ssn = ssn
    @this_address = address
    @this_customer_id = @@next_customer_id
    @@next_customer_id += 1
  end
end
