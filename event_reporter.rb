#require './lib/attendee.rb'
 # require './lib/phone_number.rb'
  require 'csv'
 
class EventReporter
    
  def initialize
    @queue = []
    @contents = ""
  end
 
  def run
    puts "Welcome!"
 
    command = ""
 
    while command != "quit"
      printf "enter command: "
      input = gets.chomp
      command = input
      parts = input.split(" ")
  
      # command => "find first_name Allison"
      # parts => 
      puts "Parts: #{parts}" # 
      puts "Command: #{command}"

      if parts[0] == "find"
        # puts "HOLLY GEEZ I'm FINDING #{parts}"
        find(parts[1], parts[2]) 
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
 
  # find("last_name","Arnold")
  def find(field,criteria)
    @contents = CSV.read "event_attendees.csv", headers: true, header_converters: :symbol 
        
    @contents.each do |row|
      column_data = row[field.to_sym]
      if column_data == criteria
        @queue.push(row)
      end    
      # add it to the queue
      
    end
  end
 
 
  def load_file
    @contents 
  end
 
  def queue_count
    @queue.length
  end
 
  def queue_clear
    @queue.clear
  end
 
  def queue_print
    puts @queue
  end
 
  def clean_phone(phone)
 
  end
 
  # def first_name("#{first_name}")
  # end

  # def last_name("#{last_name}")
  # end
 
  # def help_command(command)
  # end
 
 
  def commands_help
    @commands = {"queue clear" => "clears your queue",
                 "queue count" => "tells you current queue count",
                  "queue print" => "prints your queue",
                  "queue print by 'attribute'" => "prints data table by specific attribute",
                  "load <filename>" => "loads file (deault is event_attendees.csv",
                  "queue save to <filename.csv>" => "saves queue to specified CSV file",
                  "find 'attribute' and 'criteria'" => "finds all records matching criteria",
                  "help <command>" => "outputs description of how to use specific comman"}
    @commands.each do |key, val|
      puts "enter: \"#{key.upcase}\", #{val}"
    end         
  end
 
  # @contents = CSV.read "event_attendees.csv", headers: true, header_converters: :symbol 
 
 
  # @contents.each do |row|
 
  # id = row[0]
 
  # name = row[:first_name]
 
  #   phone = clean_phone(row[:homephone])
    
  #   zipcode = clean_zipcode(row[:zipcode])
 
  # end
 
  er = EventReporter.new
  er.run
