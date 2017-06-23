require 'rspec'
require_relative 'task'


describe Task do #task has to be a predefined class
  it "can create a task" do
    expect{Task.new}.to_not raise_error
  end

  it "can give a task a title and retrieve it" do
    task1 = Task.new
    expect(task1.title("Pay Bills")).to eq("Pay Bills")
    expect(task1.get_task).to eq("Pay Bills")
  end

  it "can give a task a description and retrieve it" do
    task1 = Task.new
    expect(task1.desc("Pick up birthday cake in Point Loma")).to eq("Pick up birthday cake in Point Loma")
    expect(task1.get_desc).to eq("Pick up birthday cake in Point Loma")
  end

  it "can mark a task done aaaaaaaaand done" do
    task1 = Task.new
    # expect(task1.stat("Complete")).to eq("Complete")
    expect(task1.completed).to eq("Completed")
  end

  it "when I print a Task that is done, its status is shown" do
      task1 = Task.new
      task1.title("Birthday Party")
      task1.desc("Get one of those Black Forest cakes in Point Loma")
      task1.stat("Complete")
      expect(task1.show).to eq("Title: Birthday Party, Description: Get one of those Black Forest cakes in Point Loma, Status: Complete")
  end

  it "adds all tasks to a task list" do
    task1 = Task.new
    task2 = Task.new
    task1.title("Rotate Tires")
    task2.title("Merlin bath")
    tasks = Tasklist.new
    tasks.add_task(task1)
    tasks.add_task(task2)
    expect(tasks.read_list).to eq([task1, task2])
  end

  it "get completed items from the class Tasklist" do
    task1 = Task.new
    task2 = Task.new
    task1.title("Rotate Tires")
    task2.title("Merlin bath")
    tasks = Tasklist.new
    tasks.add_task(task1)
    tasks.add_task(task2)
    task1.completed
    task2.completed
    expect(tasks.show_complete).to eq([task1, task2])
  end

  it "will show incomplete tasks in a given list" do
    task1 = Task.new
    task2 = Task.new
    task1.title("Rotate Tires")
    task2.title("Merlin bath")
    tasks = Tasklist.new
    tasks.add_task(task1)
    tasks.add_task(task2)
    task1.completed
    expect(tasks.show_incomplete).to eq([task2])
  end

  it "can create a due date for each task" do
    task1 = Due_task.new
    task2 = Due_task.new
    task1.title("Rotate Tires")
    task2.title("Merlin bath")
    tasks = Tasklist.new
    tasks.add_task(task1)
    tasks.add_task(task2)
    task1.due_date(2017/06/24)
    expect(task1.get_due_date).to eq(2017/06/24)
  end

  it "can print an item with a due date with labels and values" do
    task1 = Due_task.new
    task2 = Due_task.new
    task1.title("Rotate Tires")
    task2.title("Merlin bath")
    tasks = Tasklist.new
    tasks.add_task(task1)
    tasks.add_task(task2)
    task1.due_date(2017/06/24)
    task2.due_date(2018/02/27)
    expect(tasks.show_due_tasks(2017/06/24)).to eq([task1])
    expect(tasks.add_scheduled_task(task1)).to eq([task1])
  end

  it "can add items with due dates to my TaskList" do
    task1 = Due_task.new  #make a couple of scheduled tasks
    task2 = Due_task.new
    task1.title("Change oil")
    task2.title("Eat lots of greasy food")
    task1.due_date(2017/06/25)
    task2.due_date(2017/06/26)
    to_dos = Tasklist.new   #make a new object of class Tasklist
    to_dos.add_scheduled_task(task1) #add a task to Tasklist of the scheduled class
    to_dos.add_scheduled_task(task2)
    expect(to_dos.get_scheduled_task).to eq([task1, task2]) #Can pass to eq more than 1 argument, as long as all arguments are in an array
  end

  it "list all the not completed items that are due today" do
    task1 = Due_task.new  #make a couple of scheduled tasks
    task2 = Due_task.new
    task3 = Due_task.new
    task1.title("go to job fair")
    task2.title("drink lots of beer")
    task3.title("laundry")
    task1.due_date("06/23/2017")
    task2.due_date("06/23/2017")
    task3.due_date("07/28/2017")
    list = Tasklist.new
    list.add_scheduled_task(task1)
    list.add_scheduled_task(task2)
    list.add_scheduled_task(task3)
    expect(list.get_inc_due_today).to eq([task1, task2])
    task1.completed
    expect(list.get_inc_due_today).to eq([task2])

  end

  it "can list all the incompleted items in order of due date" do
    task1 = Due_task.new  #make a couple of scheduled tasks
    task2 = Due_task.new
    task3 = Due_task.new
    task1.title("Generic Task 1")
    task2.title("Different Task 2")
    task3.title("Slightly unimportant task 3")
    task1.due_date("06/25/2017")
    task2.due_date("06/23/2017")
    task3.due_date("07/28/2017")
    list = Tasklist.new
    list.add_scheduled_task(task1)
    list.add_scheduled_task(task2)
    list.add_scheduled_task(task3)
    expect(list.show_inc_by_date).to eq([task2, task1, task3])
  end

  it "can list all the incompleted items in order of due date, and then the items without due dates" do
    task1 = Due_task.new  #make a couple of scheduled tasks
    task2 = Due_task.new
    task3 = Due_task.new
    task1.title("Slay dragon")
    task2.title("Out-swim mer-people")
    task3.title("Go through maze")
    task1.due_date("09/28/2017")
    task2.due_date("08/28/2017")
    task3.due_date("07/28/2017")

    task4 = Task.new  #make a couple of scheduled tasks
    task5 = Task.new
    task6 = Task.new
    task4.title("Play video games")
    task5.title("Play tennis")
    task6.title("Mini golf")

    list = Tasklist.new
    list.add_scheduled_task(task1)
    list.add_scheduled_task(task2)
    list.add_scheduled_task(task3)

    list.add_task(task4)
    list.add_task(task5)
    list.add_task(task6)

    expect(list.show_inc_by_date).to eq([task3, task2, task1])
    expect(list.get_unscheduled_task).to eq([task4, task5, task6])
  end
end #ends describe


# Story: As a developer with a TaskList with and without due dates, I can list all the not completed items in order of due date, and then the items without due dates.

 # task1 = Task.new #make new task.
 # => #<Task:0x007fdc6b084540 @stat="Incomplete">
 # task2 = Task.new #make another new class
 # => #<Task:0x007fdc6b074398 @stat="Incomplete">
 # list = Tasklist.new #make a new task list
 # => #<Tasklist:0x007fdc6b066888 @tasks=[], @completed_tasks=[], @incompleted_tasks=[]>
 # list.add_task(task1) #Used our own methods to add task1 to the list. We did this because we wanted to preserve the data type. Adding an item to the list "manually" using list = [task1, task2] is valid, but it changes the class type of list from it's original type "Tasklist" to Array. This is problematic because once it changes to an array, the methods we wrote for the Tasklist class are no longer available.
 # => [#<Task:0x007fdc6b084540 @stat="Incomplete">]
 # list.add_task(task2) #Again use our own methods to add a task to the list
 # => [#<Task:0x007fdc6b084540 @stat="Incomplete">, #<Task:0x007fdc6b074398 @stat="Incomplete">]
 # list.class #verify the data type is still Tasklist after adding items
 # => Tasklist
 # list.show_incomplete #All added items so far should be incomplete. IRB verified this to be true
 # => [#<Task:0x007fdc6b084540 @stat="Incomplete">, #<Task:0x007fdc6b074398 @stat="Incomplete">]
 # list.show_complete #No items should be completed yet since we haven't called on out method to complete an item. IRB also verified this as true
 # => []
 # task1.completed #Still use out methods we wrote to complete task1.
 # => "Completed"
 # list.show_complete #IRB verifying completed task1. This worked perfectly
 # => [#<Task:0x007fdc6b084540 @stat="Completed">]
