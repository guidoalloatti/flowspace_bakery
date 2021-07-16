Flowspace Bakery
================

Flowspace Bakery is an artisanal digital bakery, crafting the finest digital cookies in New York City.

We don't mass produce our cookies in faceless factories. Instead, We bake cookies to order, one at a time.

Reference Application
---------------------
A reference application can be found at [http://flowspace-bakery.herokuapp.com](http://flowspace-bakery.herokuapp.com)

HTTP Auth access: bake / somecookies

Test Suite
----------
Like most bakeries, Flowspace Bakery has a test suite. The full suite can be run with:

``
$ bundle exec rspec spec
``

Requirements
-------------

This application requires:

- Ruby 2.6.2
- PostgreSQL server running on localhost

Resolution Explanation
----------------
- `mainline` is the principal branch.
- I created one separate branch for each of the development challenges, in some cases I determined that a few of the branches needed to have merged previous stories to work properly.
- The branches for the resolutions of the first bug has 2 different approaches since I found some small ambiguities in the exercise text so I choose to resolve the issue in 2 ways just to be sure, that can be found in branches:
	- bugfix/FLOWSPACE-1
	- bugfix/FLOWSPACE-1.1
- Anohter exception is the feature for challenge 4, in there I first resolve it and then I decided to provide a better solution since the first one was solid enough, both solutions can be found in the branches:
	- feature/FLOWSPACE-4
	- feature/FLOWSPACE-4.1

Steps
----------------
- Install and Set rails version to `2.6.2` (rbenv or rvm)
- Run: `$ bundle install`
- Run: `$ rake db:create`
- Run: `$ rake db:migrate`

Start Rails Server
----------------
- Run: `$ rails s`

Start Sidekiq Server
----------------
- Run: `$ bundle exec sidekiq`

Visit the page
----------------
- Go to: `localhost:3000`
- Complete the credentials:
	- Username: `bake`
	- Password: `somecookies`
- Register and login.
- Bake some cookies!