1. Make sure Postgres is running in a lone terminal window/tab.

2. In a new window/tab, run psql, and do this (make sure your semicolons are there!):
  - # CREATE DATABASE simple;
  - # \c simple;
  - # CREATE TABLE tasks (id serial PRIMARY KEY, task varchar);

3. In a new window/tab, run IRB and do this stuff:
  - Copy ALL of the code (including the require- were you listening? I said ALL of the code) in 'simple.rb' and paste in IRB. Press enter if need be- you should see a return of => :access (this is the last method created in the class).

  The rest remains in IRB.

  - > task = Task.new(:task => "anything you want")
  - > task.save

    THE FUN PART:

  - > Task.access[0]
        Cool! It saved a thing to the database, and now we can access it! Now try:
  - > Task.access[0].fetch("id")
        Wow! We can access any part of the task that we inserted into the database (the id is inserted automatically, as we created a 'serial' value in the database for 'id').
  - > Task.access[0].fetch("task")
        Fuckin' sweet! We can see the individual task! Let's add another item:

  - > task2 = Task.new(:task => "Another task!")
  - > task2.save

        Now, we have two items in our database. Let's get weird! Try this:

  - > search_query = DB.exec("SELECT * FROM tasks WHERE id = 1;")
  - > search_query[0]
        Brah/Brosephine! We got an "array" (it's not a true array, but PG's awesome-ass version of one) of only the matching things! Though we have two items in our database, search_query will only contain things with the id of 1. In the next line, we'll see that this "array" does not contain anything that does not have the id of 1. Remember that an array index starts at 0!

  - > search_query[1]
        Error city! The search_query variable only asks for things with the id of 1. The queried array only contains one item, and arrays start at 0.

        You probably get the point, but for shits and giggles, let's try this:

  - > search_query = DB.exec("SELECT * FROM tasks WHERE task = 'anything you want'")
  - > search_query[0]
        LET'S DO THE RICK DANCE! This "array" only contains the item we queried, and not the other item in the database. To prove that:
  - > search_query[1]
        It ain't there! I've never been so happy to see an error.  Giddyup, let's get a Coors light.

        Just to drive it home, do this:

  - > search_query = DB.exec("SELECT * FROM tasks WHERE task = 'Another task!'")
  - > search_query[0]
        and, again, this will be the only thing in our query:
  - > search_query[1]
        Errors are our friend here! The search_query variable only contains the item we wanted. Time for another beer! 

As you may see, the possibilities are limitless from here- we can access any row in our database, and any part of a row in our database. IMO, creating a seperate array and pushing each thing to it is pointless, but I'm sure I'll eat those words next week!
