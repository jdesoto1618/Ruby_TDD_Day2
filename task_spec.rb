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
    expect(tasks.add_scheduled_task(task1)).to eq(task1)

  end

  it " As a developer with a TaskList, I can list all the not completed items that are due today" do
    task1 = Due_task.new
    task2 = Due_task.new
    task1.title("Rotate Tires")
    task2.title("Merlin bath")
    tasks = Tasklist.new
    tasks.add_task(task1)
    tasks.add_task(task2)
    task1.due_date(2017/06/24)
    task1.completed
    task2.due_date(2018/02/27)
    expect(tasks.show_due_tasks(2017/06/24)).to eq([task1])
    expect(tasks.show_incomplete)
    #TODO: Create some sort of AND statement with incomplete tasks and the dates
  end


end #ends describe

# Story: As a developer with a TaskList, I can list all the not completed items that are due today.





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
