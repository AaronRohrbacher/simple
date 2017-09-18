require('pg')

class Task
  attr_reader(:task)
  DB= PG.connect({:dbname => 'simple'})

  def initialize(attributes)
    @task = attributes.fetch(:task)
  end

  def save
    DB.exec("INSERT INTO tasks (task) VALUES ('#{@task}');")
  end

  def self.access
    returned_tasks = DB.exec("SELECT * FROM tasks;")
  end
end
