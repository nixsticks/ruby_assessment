# 1. Arrays

array = ["Blake", "Ashley", "Jeff"]

# a. Add a element to an array
array.push("Avi")

# b. Write a statement to print out all the elements of the array.
array.each { |name| puts name }

# c. Return the value at index 1.
array[1]

# d. Return the index for the value "Jeff".
array.index("Jeff")


# 2. Hashes

instructor = { :name => "Ashley", :age => 27 }

# a. Add a new key for location and give it the value "NYC".
instructor[:location] = "NYC"

# b. Write a statement to print out all the key/value pairs in the hash
instructor.each { |key, value| puts "#{key}, #{value}" }

# c. Return the name value from the hash.
instructor[:name]

# d. Return the key name for the value 27.
instructor.key(27)


# 3. Nested Structures

school = { 
  :name => "Happy Funtime School",
  :location => "NYC",
  :instructors => [ 
    {:name=>"Blake", :subject=>"being awesome" },
    {:name=>"Ashley", :subject=>"being better than blake"},
    {:name=>"Jeff", :subject=>"karaoke"}
  ],
  :students => [ 
    {:name => "Marissa", :grade => "B"},
    {:name=>"Billy", :grade => "F"},
    {:name => "Frank", :grade => "A"},
    {:name => "Sophie", :grade => "C"}
  ]
}

students = school[:students]
instructors = school[:instructors]

# a. Add a key to the school hash called "founded_in" and set it to the value 2013.
school[:founded_in] = "2013"

# b. Add a student to the school's students' array.
students.push( {:name => "Kate", :grade => "A"} )

# c. Remove "Billy" from the students' array.
students.slice!(1)

# d. Add a key to every student in the students array called "semester" and assign it the value "Summer".
students.each { |hash| hash[:semester] = "Summer" }

# e. Change Ashley's subject to "being almost better than Blake"
instructors[1][:subject] = "being almost better than Blake"

# f. Change Frank's grade from "A" to "F".
students[1][:grade] = "F"

# g. Return the name of the student with a "B".
students[0][:name]

# h. Return the subject of the instructor "Jeff".
instructors[2][:subject]

# i. Write a statement to print out all the values in the school. ***FLAG
school.each do |key, value|
	if value.is_a?(String)
		puts value
	else
		value.each do |array|
			array.each do |key, value|
				puts value
			end
		end
	end
end


# 4. Methods
# Note: You will need to pass the school variable to each of these methods to include it in scope.

# a.
# i. Create a method to return the grade of a student, given that student's name. 
def return_grade(list, name)
	list.each do |student|
		if student[:name] == name
			return student[:grade]
		end
	end
end

return_grade(students, "Frank")

#ii. Then use it to refactor your work in 3.i.
# Kate and I told Blake we don't understand this question and he said to ignore it for now

# b. 
# i. Create a method to update a instructor's subject given the instructor and the new subject. 
def update_instructor(list, name, subject)
	list.each do |instructor|
		if instructor[:name] == name
			instructor[:subject] = subject
		end
	end
end

#ii. Then use it to update Blake's subject to "being terrible".
update_instructor(instructors, "Blake", "being terrible")

# c. 
# i. Create a method to add a new student to the schools student array. 
def new_student(list, name, grade, semester)
	list.push( {:name => name, :grade => grade, :semester => semester} )
end

#ii. Then use it to add yourself to the school students array.
new_student(students, "Nikki", "A", "Winter")

# d. 
#i. Create a method that adds a new key at the top level of the school hash, given a key and a value. 
def new_key(list, key, value)
	list[key] = value
end

#ii. Then use it to add a "Ranking" key with the value 1.
new_key(school, :ranking, "1")


# 5. Object Orientation

# a. Create a bare bones class definition for a School class.
class School

	# g. Create an array constant SCHOOLS that stores all instances of your School class.
	SCHOOLS = []

	# h. Create a class method reset that will empty the SCHOOLS constant.
	def School.reset
		School::SCHOOLS.clear
	end

	# c. Create an attr_accessor for name, location, instructors, and students. Create an attr_reader for ranking.
	attr_accessor :name, :location, :instructors, :students
	attr_reader :ranking

	# b. Define an initialize method for the School class...etc.
	def initialize(name, location, ranking, students, instructors)
	# Since we were asked to put in a parameter for each instance variable, here you can pass in a hash as an argument
	# for students and instructors and it will be placed in the array. It could also just be left as a blank array 
	# so you can use the methods defined later to add students (but there is no instructor method).
	#OverthinkingIt
		@name = name
		@location = location
		@ranking = ranking
		@students = [students]
		@instructors = [instructors]
		SCHOOLS.push(self)
	end

	# d. Create a method to set ranking, given a ranking value.
	def set_ranking(value)
		@ranking = value
	end

	# e. Create a method to add a student to the school, given a name, a grade, and a semester.
	def add_student(name, grade, semester)
		students.push( {:name => name, :grade => grade, :semester => semester} )
	end

	# f. Create a method to remove a student from the school, given a name.
	def remove_student(name)
		students.each do |student|
			if student[:name] == name
				students.delete(student)
			end
		end
	end

end


# 6. Classes

# a. Create a Student class.
class Student

	attr_accessor :name, :grade, :semester

	def initialize(name, grade, semester)
		@name = name
		@grade = grade
		@semester = semester
	end

end

class School

	attr_accessor :name, :location, :instructors, :students
	attr_reader :ranking

	def initialize(name, location, ranking)
		@name = name
		@location = location
		@ranking = ranking
		@students = []
		@instructors = []
		# Students (and instructors) intentionally left blank so we can fill them using the add_student method and possibly later an add_instructor.
		SCHOOLS.push(self)
	end

	def set_ranking(value)
		@ranking = value
	end

	# b. Refactor your School instance methods to treat Students as an array of objects instead of an array of hashes.
	def add_student(name, grade, semester)
		students.push(Student.new(name, grade, semester))
	end

	def remove_student(name)
		students.each do |student|
			if student.name == name
				students.delete(student)
			end
		end
	end

	# c. Create a method in the School class that finds a student by name and returns the correct Student object.
	def find_student(name)
		students.each do |student|
			if student.name == name
				return student
			end
		end
	end

	SCHOOLS = []

	def School.reset
		SCHOOLS.clear
	end

end


# 7. Self

# For this section, please use the letters and answer each individually.
# Note: in cases where self is an instance of an object just note that as the object id printed to the screen is going to be different everytime

# a. What should this Class print to the screen when defined/loaded?
# "hello"
# Student (as in the name of the class)

# b. What should this Class print to the screen when defined/loaded?
# Student

# c. What should this Class print to the screen when defined/loaded?
# The object id of a new instance of the Student class.

# d. What should this code print to the screen when run?
# The object id of a new instance of the Student class.

# e. What should this code print to the screen when run?
# "goodbye"
