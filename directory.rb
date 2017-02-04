@students = [] # accessible to all methods
@required_info = [:name,:cohort,:height,:hobbies,:birthplace] # add new symbols to this to extend the data collection
@months = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
@prompt = "\n> "
@linewidth = 50
@linespacer = ' '

def hr
  puts "\n", "".center(@linewidth,'-')
end

def print_menu
  puts "1. Add Students"
  puts "2. Show All Students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    print @prompt
    process($stdin.gets.chomp)
  end
end

def ask(verb)
  puts "Would you like to #{verb} a particular file?"
  puts "Please enter the file path."
  puts "To use the default, hit return."
end

def process(selection)
  system("clear")
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    ask("save")
    print @prompt
    filename = gets.chomp
    system("clear")
    if filename.empty?
      save_students
    else
      save_students(filename)
    end
  when "4"
    ask("load")
    print @prompt
    filename = gets.chomp
    system("clear")
    if filename.empty?
      load_students
    else
      load_students(filename)
    end
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
    puts hr
  end
end

def defaulter # function which gets user input and defaults it if empty
  print @prompt
  str = $stdin.gets[0..-2] # alternative to gets.chomp using range selection, from index 0 to the last-but-one character (removes the last return)
  if str.empty?
    str = "None provided"
  end
  return str
end

def student_info_input(name, requested_info)
  responded_info = []
  requested_info.each do |info|
    if info == :name
      responded_info << name
    else
      puts "\nPlease enter this student's #{info}"
      if info == :cohort
        response = defaulter.downcase.to_sym
        while !@months.include? response
          puts "Please try again.\nEnter a month for the student's cohort"
          response = defaulter.downcase.to_sym
        end
        responded_info << response
      else
        response = defaulter
        responded_info << response
      end
    end
  end
  return responded_info
end

def input_students
  puts hr
  puts " Ready to add students ".center(@linewidth,'-')
  puts hr
  puts "Please enter the name of a student"
  puts "To quit, just hit return."
  # get the first name
  print @prompt
  name = $stdin.gets[0..-2]
  # while the name is not empty, repeat this code
  while !name.empty? do
    data = student_info_input(name, @required_info)
    add_student_data(data)
    print "\nNow we have #{@students.count} student"
    unless @students.length == 1
      print "s"
    end;
    puts "."
    # get another name from the user
    puts "Please enter another student's name"
    puts "To quit, just hit return."
    print @prompt
    name = $stdin.gets[0..-2]
  end
  # return array of students
  system("clear")
  @students
end

def print_header
  puts hr
  puts "The Students of Villains Academy".center(@linewidth,@linespacer)
  puts hr
end

def print_student_data(student)
  student.each do |info|
    unless info[0] == :name
      puts " #{info[0].capitalize}: #{info[1].capitalize} ".center(@linewidth,@linespacer)
    end
  end
  puts hr
end

def print_students_by_month
  incrementer = 1
  @months.map do |month|
    @students.map do |student|
      unless !student[:cohort].to_s.include? month.to_s
        puts "#{incrementer}. #{student[:name]}"
        print_student_data(student)
        incrementer += 1
      end
    end
  end
end

def print_footer
  print "\nOverall, we have #{@students.count} great student"
  unless @students.length == 1
    print "s"
  end
  puts "."
end

def show_students
  print_header
  print_students_by_month
  print_footer
end

def save_students(filename = "students.csv")
  # open file
  File.open(filename, "w") { |file|
  # iterate over students
  @students.each do |student|
    student_data = []
    student.each do |info|
      student_data << info[1]
    end
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  } # end of File.open's block will close file automatically
  puts hr
  puts " Successfully Saved #{@students.count} Students ".center(@linewidth,'-')
  puts hr
end

def student_hash_generator(data)
  student_hash = {}
  while @required_info.length > data.length
    data << "None provided"
  end
  student_hash = [@required_info, data].transpose.to_h
end

def add_student_data(data)
  @students << student_hash_generator(data)
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    load_students
  elsif File.exists?(filename)
    load_students(filename)
    puts "Loaded from #{filename}\n"
  else
    puts "Sorry, #{filename} doesn't exist."
    Exit
  end
end

def load_students(filename = "students.csv")
  @students = []
  File.open(filename, "r") { |file|
  file.readlines.each do |line|
    data = line.chomp.split(',')
    add_student_data(data)
  end
  }
  puts hr
  puts " Successfully Loaded #{@students.count} Students ".center(@linewidth,'-')
  puts hr
end

try_load_students
interactive_menu
