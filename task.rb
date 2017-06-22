require 'date'

class Task
  def initialize
    @stat = "Incomplete"
    @scheduled = "Unscheduled"
  end

  def title(task) #sets task
    @task = task
  end

  def get_task #gets task
    @task
  end

  def desc(desc)
    @desc = desc
  end

  def get_desc
    @desc
  end

  def stat stat
    @stat = stat
  end

  def read_stat
    @stat
  end

  def completed
    @stat = "Completed"
  end

  def show
    return "Title: #{@task}, Description: #{@desc}, Status: #{@stat}"
  end

  # def due_date(date) #needs to be in format 2017-06-24. Is the setter for date
  #   @due_date = date
  # end
  #
  # def get_due_date #Gets the due date
  #   @due_date
  # end
end #end class Task

#Each method only works on an object of that class.
#We created a new class Tasklist to hold all the tasks, in a very similar fashion to how the garage class holds all the cars we pass into it
class Tasklist
  def initialize
    @tasks = []
    @completed_tasks = []
    @incompleted_tasks = []
    @scheduled_tasks = []
    @due_tasks = []
  end

  def add_task(task) #Setter
    @tasks = @tasks.push(task)
  end

  def add_scheduled_task(task) #Setter
    # @tasks = @tasks.push(task)
      @scheduled_tasks = task
  end

  def read_list #Getter
    @tasks
  end

  def show_complete
    @tasks.select { |item| if item.read_stat == "Completed"
      # @completed_tasks = item
      item
    end }
    # take the tasks array, extract only those elements in the array which are "completed"
    # return an array that is  @tasks filtered by if stat is Completed
  end

  def show_incomplete
    @tasks.select { |item| if item.read_stat == "Incomplete"
      # @incompleted_tasks = item
      item
    end }
  end

  def show_due_tasks (date)
    @tasks.select { |item| if item.get_due_date == date
      item
    end } #ends if
  end #ends def
end #end class Tasklist

class Due_task < Task #Inherits from Task class
  def initialize
    super
    @scheduled = "Scheduled"
  end

  def due_date(date) #needs to be in format 2017-06-24. Is the setter for date
    @due_date = date
  end

  def get_due_date #Gets the due date
    @due_date
  end
end #ends Due_task
