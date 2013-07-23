class Employee
  attr_reader :name, :title, :salary
  attr_accessor :boss

  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
  end

  def calculate_bonus(multiplier)
    self.salary * multiplier
  end
end

class Manager < Employee
  attr_reader :minions

  def initialize(name, title, salary)
    super(name, title, salary)
    @minions =[]
  end

  def add_employee(employee)
    @minions << employee
    employee.boss = self
  end

  def calculate_bonus(multiplier)
    total = 0
    @minions.each { |minion| total += minion.salary }
    total * multiplier
  end
end