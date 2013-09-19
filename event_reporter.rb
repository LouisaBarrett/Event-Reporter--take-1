#require './lib/attendee.rb'
 # require './lib/phone_number.rb'
  require 'csv'
 
class EventReporter
    
  #attr_accessor :contents
  def initialize
    @queue = []
    @contents = ""
    @x = 0
  end
 
  def run
    puts "Welcome!"
 
    command = ""
 
    while command != "quit"
      if @x != 1
      printf "Type \"load\" to specify your document: "
      else 
        printf "enter command: "
      end
      input = gets.chomp
      command = input
      parts = input.split(" ")

      # puts "Parts: #{parts}" 
      # puts "Command: #{command}"

      if parts[0] == "find"
        find(parts[1], parts[2]) 
      end

      if parts[0] == "load"
        load_file(parts[1])
      end

      if parts[0] == "save"
        save_csv_file(parts[1])
      end

      case command
        when "quit" 
          puts "goodbye"
        when "queue count"
          puts "There are #{queue_count} items in the queue" 
        when "queue clear"
          queue_clear
          puts "There are #{queue_count} items in the queue"
        when "help"
          commands_help
        when "queue print"
          queue_print
        end
      end


    end
  end
 
  def find(field,criteria)
    #@contents = CSV.read "event_attendees.csv", headers: true, header_converters: :symbol 
        
    @contents.each do |row|
      column_data = row[field.to_sym]
      if column_data == criteria
        @queue.push(row)
      end    
    end
  end
 
 
  def load_file(filename)
    @contents = CSV.read "#{filename}", headers: true, header_converters: :symbol 
    @x = 1
  end
  
  def save_csv_file(name)
    Dir.mkdir("attendees") unless Dir.exists?("attendees")

    filename = "attendees/#{name}.csv"

    File.open(filename, 'w') do |file|
      file.puts @queue
    end
  end
 
  def queue_count
    @queue.length
  end
 
  def queue_clear
    @queue.clear
  end
 
  def queue_print
    @queue.to_s.upcase
      puts "LAST_NAME".ljust(15)+"FIRST_NAME".ljust(15)+"EMAIL".ljust(50)+"ZIPCODE".ljust(15)+"CITY".ljust(30)+"STATE".ljust(15)+"ADDRESS".ljust(50)+"PHONE".ljust(15)
      @queue.each do |row|
      puts row[:last_name].ljust(15)+row[:first_name].ljust(15)+row[:email_address].ljust(50)+row[:zipcode].ljust(15)+row[:city].ljust(30)+row[:state].ljust(15)+row[:street].ljust(15)+"#{@phonenumber}"
    end
  end
 
  def clean_phone(phone)
  end 
 
  def commands_help
    @commands = {"queue clear" => "clears your queue",
                 "queue count" => "tells you current queue count",
                  "queue print" => "prints your queue",
                  "queue print by 'attribute'" => "prints data table by specific attribute",
                  "load <filename>" => "loads file (deault is event_attendees.csv",
                  "save to <filename.csv>" => "saves queue to specified CSV file",
                  "find 'attribute' and 'criteria'" => "finds all records matching criteria",
                  "help" => "outputs description of all command functions"}
    @commands.each do |key, val|
      puts "enter: \"#{key.upcase}\", #{val}"
    end         
  end
 
 
  #   phone = clean_phone(row[:homephone])
    
  #   zipcode = clean_zipcode(row[:zipcode])
 
 
  er = EventReporter.new
  er.run
