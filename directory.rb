$months = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
$linewidth = 50
$linespacer = ' '

def defaulter(str) # function which gets user input and defaults it if empty
  str = gets.chomp
  if str.empty?
    str = "None provided"
  end
  return str
end

def input_students
  puts "Please enter the name of a student"
  puts "To quit, just hit return twice."
  # create empty array
  students = []
  # get the first name
  name = gets.chomp
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
    students << {name: name, cohort: cohort, height: height, hobbies: hobbies, birthplace: birthplace}
    print "\nNow we have #{students.count} student"
    unless students.length == 1
      print "s"
    end;
    puts "."
    # get another name from the user
    puts "Please enter another student's name"
    puts "To quit, just hit return."
    name = gets.chomp
  end
  # return array of students
  students
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

def printbymonth(students)
  $months.map do |month|
    students.map do |student|
      unless !student[:cohort].to_s.include? month.to_s
        incrementer = 0
        puts "#{incrementer+1}. #{student[:name]}"
        puts " Birthplace: #{student[:birthplace]} ".center($linewidth,$linespacer)
        puts " Height: #{student[:height]} ".center($linewidth,$linespacer)
        puts " Hobbies: #{student[:hobbies]} ".center($linewidth,$linespacer)
        puts " Cohort: #{student[:cohort].capitalize} ".center($linewidth,$linespacer)
        incrementer += 1
      end
    end
  end
end

def print_footer(students)
  print "\nOverall, we have #{students.count} great student"
  unless students.length == 1
    print "s"
  end
  puts "."
end

# nothing happens 'til we call methods
students = input_students
print_header
puts "Ordered By Month:"
printbymonth(students)
print_footer(students)
