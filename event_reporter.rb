require 'csv'

class EventReporter

  def initialize
    @queue = []
    @commands = { 'queue clear' => "clears out queue", 
      'queue count' => "counts your queue",
      'queue print' => "prints the queue" }
  end

  def run
   #pull from mircoblogger
    puts "Welcome to Event Reporter"
    command = ""
      while command != "quit"
       printf "enter command: "
        input = gets.chomp
        command = input

      case command
        when "quit" then 
          puts "Goodbye"
        when "queue count" then 
          puts "#{queue_count}"
        when "queue clear" then 
          queue_clear
          puts "Queue Cleared"
        when 'help'
          puts @commands.keys
        when "help queue count"
          puts "queue count : #{@commands["queue count"]}"
        when "help queue print"
          puts "queue print : #{@commands["queue print"]}"
      end
    end
  end

  # def execute_command
  # end

  def load_file
    @contents = CSV.read 'event_attendees.csv', headers: true, header_converters: :symbol
  end

  def commands
    @commands
  end


  def queue_count
    @queue.length
  end

  def find(criteria)
    #"attribute" => "criteria"
  end

  def queue_clear
    @queue.clear
  end


end

er = EventReporter.new
er.run