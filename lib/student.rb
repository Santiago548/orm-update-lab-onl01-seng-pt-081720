require_relative "../config/environment.rb"
require 'pry'

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
<<<<<<< HEAD
  attr_accessor :name, :grade, :id

  def initialize( id = nil, name, grade)
    @id = id
    @name = name
    @grade = grade
=======
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
>>>>>>> e3b4d495c2fce3589a43e70185a7783ca4114c19
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students;"
    DB[:conn].execute(sql)
  end

  def save
    if self.id
      self.update
    else
        sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

      DB[:conn].execute(sql, self.name, self.grade)

      @id = DB[:conn].last_insert_row_id
    end
  end

  def self.create(name, grade)
    student = Student.new(name, grade)
    student.save
    student
  end

  def self.new_from_db(row)
    id = row[0]
    name = row[1]
    grade = row[2]
    self.new(id, name, grade)
  end

  def self.find_by_name(name)
<<<<<<< HEAD
    sql = <<-SQL
      SELECT *
      FROM students
      WHERE name = ?
      LIMIT 1
    SQL

    DB[:conn].execute(sql,name).map do |row|
      self.new_from_db(row)
    end.first
=======
    # find the student in the database given a name
# return a new instance of the Student class
sql = <<-SQL
  SELECT *
  FROM students
  WHERE name = ?
  LIMIT 1
SQL

DB[:conn].execute(sql,name).map do |row|
  self.new_from_db(row)
end.first
>>>>>>> e3b4d495c2fce3589a43e70185a7783ca4114c19
  end

  def update
    sql = "UPDATE students SET name = ?, grade = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.grade, self.id)
  end

end
