@students = [] # accessible to all methods
$months = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
$linewidth = 50
$linespacer = ' '

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def defaulter(str) # function which gets user input and defaults it if empty
  str = gets[0..-2] # alternative to gets.chomp using range selection, from index 0 to the last-but-one character (removes the last return)
  if str.empty?
    str = "None provided"
  end
  return str
end

def input_students
  puts "Please enter the name of a student"
  puts "To quit, just hit return."
  # get the first name
  name = gets[0..-2]
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    puts "Please enter this student's cohort."
    cohort = defaulter(cohort).downcase.to_sym # this defaulter function does the gets.chomp and checks the default value in one go
    while !$months.include? cohort
      puts "Please try again.\nEnter a month for the student's cohort"
      cohort = defaulter(cohort).downcase.to_sym
    end
    puts "Please enter this student's height."
    height = defaulter(height)
    puts "Please enter this student's favourite hobby."
    hobbies = defaulter(hobbies)
    puts "Please enter this student's country of birth."
    birthplace = defaulter(birthplace)
    @students << {name: name, cohort: cohort, height: height, hobbies: hobbies, birthplace: birthplace}
    print "\nNow we have #{@students.count} student"
    unless @students.length == 1
      print "s"
    end;
    puts "."
    # get another name from the user
    puts "Please enter another student's name"
    puts "To quit, just hit return."
    name = gets[0..-2]
  end
  # return array of students
  @students
end

def print_header
   puts "The students of Villains Academy"
   puts "----------"
end

# Not using this function anymore.
#def print(students)
#  incrementer = 0
#  while incrementer < students.length
#      counter = students.index(students[incrementer])+1
#      puts "#{counter}. #{students[incrementer][:name]}"
#      puts " Birthplace: #{students[incrementer][:birthplace]} ".center($linewidth,$linespacer)
#      puts " Height: #{students[incrementer][:height]} ".center($linewidth,$linespacer)
#      puts " Hobbies: #{students[incrementer][:hobbies]} ".center($linewidth,$linespacer)
#      puts " Cohort: #{students[incrementer][:cohort]} ".center($linewidth,$linespacer)
#      incrementer += 1
#  end
#end

def print_students_by_month
  incrementer = 1
  $months.map do |month|
    @students.map do |student|
      unless !student[:cohort].to_s.include? month.to_s
        puts "#{incrementer}. #{student[:name]}"
        puts ""
        puts " Birthplace: #{student[:birthplace]} ".center($linewidth,$linespacer)
        puts " Height: #{student[:height]} ".center($linewidth,$linespacer)
        puts " Hobbies: #{student[:hobbies]} ".center($linewidth,$linespacer)
        puts " Cohort: #{student[:cohort].capitalize} ".center($linewidth,$linespacer)
        puts ""
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

def save_students
  # open file
  file = File.open("students.csv", "w")
  # iterate over students
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:height], student[:hobbies], student[:birthplace]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students
  @students = []
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, cohort, height, hobbies, birthplace = line.chomp.split(',')
      @students << {name: name, cohort: cohort.to_sym, height: height, hobbies: hobbies, birthplace: birthplace}
  end
  file.close
end

# students = input_students
# if students.length != 0
#   print_header
#   puts "Ordered By Month:"
#   printbymonth(students)
#   print_footer(students)
# end

interactive_menu
