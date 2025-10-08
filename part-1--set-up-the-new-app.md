# Part 1: Set up the new app

## Verify you have correct versions of Ruby, Rails, and Heroku CLI installed


1. Run `ruby -v` to check your Ruby version is >= 3.3.
2. Run `rails -v` to check your Rails version is 7.1.5. The assignment has not been tested with other versions, and there are files that will almost certainly cause errors with Rails >=8.*.*
5. Run `heroku -v` to verify the `heroku` [command line tool](https://devcenter.heroku.com/articles/heroku-cli) has been installed in the development environment.

## Create a new Rails app

You may find the Rails [online documentation](https://api.rubyonrails.org/) useful during this assignment.

Now that you have Ruby and Rails installed, create a new, empty Rails app with the command:

```sh
rails new ./rottenpotatoes --skip-test-unit --skip-turbolinks --skip-spring
```

The options tell Rails to omit three aspects of the new app:

* Rather than Ruby's `Test::Unit` framework, in a future assignment we will instead create tests using the RSpec framework.

* Turbolinks is a piece of trickery that uses AJAX behind-the-scenes to speed up page loads in your app.  However, it causes so many problems with JavaScript event bindings and scoping that we strongly recommend against using it.  A well tuned Rails app should not benefit much from the type of speedup Turbolinks provides.

* Spring is a gem that keeps your application "preloaded" making it faster to restart once stopped.  However, this sometimes causes unexpected effects when you make changes to your app, stop and restart, and the changes don't seem to take effect.  On modern hardware, the time saved by Spring is minimal, so we recommend against using it.

If you're interested, `rails new --help` shows more options available when creating a new app.


If all goes well, you'll see several messages about files being created, ending with run `bundle install`, which may take a couple of minutes to complete.  From now on, unless we say otherwise, **all file names and commands** will be relative to the app root.  Before going further, spend a few minutes examining the contents of the new app directory `rottenpotatoes` to remind yourself with some of the directories common to all Rails apps.

What about that message run `bundle install`?
Recall that Ruby libraries are packaged as "gems", and the tool `bundler` (itself a gem) tracks which versions of which libraries a particular app depends on. Open the file called `Gemfile` --it might surprise you that there are  already gem names in this file even though you haven't written any app code, but that's because Rails itself is a gem and also depends on several other gems, so the Rails app creation process creates a  default `Gemfile` for you.  For example,  you can see that `sqlite3` is listed, because the default Rails development environment expects to use the SQLite3 database.

OK, now ensure you're changed into the directory of the app you just created (`cd rottenpotatoes`) to continue...

## Check your work

To make sure everything works, run the app locally.  (It doesn't do anything yet, but we can verify that it is running and reachable!)

Follow the instructions below to run and preview a Rails app locally. When you visit the app's home page, you should see the generic Ruby on Rails landing page, which is actually being served by your app.  Later we will define our own routes so that the "top level" page does not default to this banner.

1. Start the app in a terminal: `rails server`  
2. Open a regular browser window to `localhost:3000/` to visit the app's home page 

Version Control
----------------
To place under version control, use these commands:

```sh
$ git add .
$ git commit -m "Initial commit"
```

The first command stages all changed files for committing. The second command commits the staged files with the comment in the quotes. You can repeat these commands to commit future changes. Remember that these are LOCAL commits -- if you want these changes on GitHub, you'll need to do a git push command, which we will show later.

-----

Next: [Part 2 - Create the database and initial migration](part-2--create-the-database-and-initial-migration.md)