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
    months = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
    cohort = defaulter(cohort).downcase.to_sym # this defaulter function does the gets.chomp and checks the default value in one go
    unless months.include? cohort
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
    puts "Now we have #{students.count} students"
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

def print(students)
  incrementer = 0
  while incrementer < students.length
      counter = students.index(students[incrementer])+1
      width = 50
      spacer = ' '
      puts "#{counter}. #{students[incrementer][:name]}"
      puts " Birthplace: #{students[incrementer][:birthplace]} ".center(width,spacer)
      puts " Height: #{students[incrementer][:height]} ".center(width,spacer)
      puts " Hobbies: #{students[incrementer][:hobbies]} ".center(width,spacer)
      puts " Cohort: #{students[incrementer][:cohort]} ".center(width,spacer)
      incrementer += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

# nothing happens 'til we call methods
students = input_students
print_header
print(students)
print_footer(students)
