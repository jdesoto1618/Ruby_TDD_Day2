
#################################################################################
#################################################################################

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

  def desc(desc) #Setter for task description
    @desc = desc
  end

  def get_desc #Getter for task description
    @desc
  end

  def stat stat #Sets the status of a task
    @stat = stat
  end

  def read_stat  #Gets the status of a task
    @stat
  end

  def completed
    @stat = "Completed"

  end

  def show
    return "Title: #{@task}, Description: #{@desc}, Status: #{@stat}"
  end


end #end class Task
#################################################################################
#################################################################################
#Each method only works on an object of that class.
#We created a new class Tasklist to hold all the tasks, in a very similar fashion to how the garage class holds all the cars we pass into it

class Due_task < Task #Inherits from Task class
  def initialize
    super
    @scheduled = "Scheduled"
  end

  def due_date(date) #needs to be in format "06/24/2017" Is the setter for date
    @due_date = date
  end

  def get_due_date #Gets the due date
    @due_date
  end
end #ends Due_task

#################################################################################
#################################################################################
class Tasklist
  def initialize
    @tasks = []
    @completed_tasks = []
    @incompleted_tasks = []
    @scheduled_tasks = []
    @unscheduled_tasks = []
    @due_tasks = []
  end

  def add_task(task) #Setter
    @tasks = @tasks.push(task)
    @incompleted_tasks = @incompleted_tasks.push(task)
    @unscheduled_tasks = @unscheduled_tasks.push(task)
  end

  def add_scheduled_task(task) #Setter
    # @tasks = @tasks.push(task)
      @scheduled_tasks = @scheduled_tasks.push(task)
      @incompleted_tasks = @incompleted_tasks.push(task)
      @due_tasks = @due_tasks.push(task)
  end

  def get_scheduled_task #Getter to get ALL scheduled tasks
      # @scheduled_tasks.select { |item| item }
      @scheduled_tasks
  end

  def get_unscheduled_task #Getter to get ALL scheduled tasks
      # @scheduled_tasks.select { |item| item }
      @unscheduled_tasks
  end

  def get_inc_due_today
    today = Date.today
    today = today.strftime('%m/%d/%Y') #get today's date in correct form
    @incompleted_tasks.reject! { |item| if item.read_stat == "Completed"
      item
    end } #Want to filter completed items from the arrray incomplete_items. This came up when we tested this method, and also inserted tasks that we made complete. The array held all tasks, whether complete or not. The reject! takes out an items from an array, but using bang modifies the original array
    @incompleted_tasks.select { |item| if item.get_due_date == today
      item
    end }

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

  def show_inc_by_date
    @incompleted_tasks.reject! { |item| if item.read_stat == "Completed"
      item
    end } #end if
    @incompleted_tasks.sort_by! { |a| a.get_due_date }
  end #end def

  def show_due_tasks (date)
    @tasks.select { |item| if item.get_due_date == date
      item
    end } #ends if
  end #ends def
end #end class Tasklist
#################################################################################
#################################################################################
