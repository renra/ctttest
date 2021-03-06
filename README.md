## CTT Innovations | Rails ninja test

Dear ninja, 

I would like to introduce you a small challenge you will face:

Your task is to create a simple agile project management tool. Application
should work across major browsers without having significant issues. Once you have 
stable version you are required to deploy it to Heroku (http://www.heroku.com/) Ruby
platform, where you can register yourself and get free account which is enough to 
host the application.

We require you to use Git as version control system, which is fundamental tool for 
our development process. Setup yourself Github account (https://github.com/) if you dont
have one already. After you've done so, you can fork the ctttest repository to your
account and start working on that. Alternatively you can download all the source code
in zip file and unpack. At any case publish your work progress to the github repository.

We would like you to follow this:

* commit often, so your work is split into smaller chunks
* write descriptive comments to your commits so we can understand what are you doing

# Requirements

* System has two major roles "account owner", "developer".

* System should allow user to sign up for the app. Signed up user will automatically became "account owner".
  
* An account will be created after sign up. The account is security scope so all what is defined inside 
  (projects, team member, stories) shouldn't be visible by users for another account.

* Account owner is able to create, read, update and delete Developers

* Each developer will have its own user in the system, first name, last name, email and password.

* Account owner is able to create, read, update and delete Projects

* Each project has its title, description, client, due date and manager.

* Each developer is able to sign in and see projects within his account.

* Developer is able to read project. Is not able to delete, update or create projects.

* Developer can create, read, update and delete story.

* Each story has its title, description, estimation on point scale (1,2,3,5,8,20,100), 
  requestor (person who created) and responsible person (requestor or another member of 
  the project team) and state (possible states are listed bellow)

* Each story has life-cycle as not ready / waiting / started / finished / delivered / accepted / rejected.

* Developer can change story states like this: 
  not ready > waiting
  waiting > started, 
  started > finished, 
  finished > delivered,  
  delivered > rejected, 
  rejected > started,
  delivered > accepted.

* In project page there should be visible how much stories are accepted, how much stories are in progress (started, finished, delivered) and how much stories are waiting.

* Stories should be displayed in the ordered list, Developer should be able to adjust order (arrows up/down or drag'n'drop).

For inspiration how UI should look check this https://www.pivotaltracker.com/. Its professional Agile project management
tool, which include features described above + many others.

Good Luck!