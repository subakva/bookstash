BookStash
==========

Store and categorize eBooks online.

Features
----------

* Upload ebooks in multiple formats
* Download ebooks into eReaders and eReader apps
* tag eBooks
* display eBooks by tag/tags
* user accounts
* store ebooks on dropbox

Tech Tasks
----------
* sass/compass
* haml
* mongoid (use the simple mongoid cms?)
* paperclip / document storage?
* factory_girl
* sidekiq
* devise
* rollout (or similar)
* user roles (cancan?)
* tagging/categorization (with mongoid search?)
* guard
* capybara
* jasmine?
* backbone / ember ?
* airbrake / newrelic / exceptional
* newrelic
* heroku
* caching (cloudfront? heroku something?)
* static controller


Thinking About Configuration
----------
secure configuration should be in files or environment variables
non-secure configuration can be in files or in a database
 - config in a database (with a shared cache) allows config to be updated without restarting apps/workers
 - config in a file is easier. it would still be possible to refresh settings without restarting apps if the app can be told to reload the config
 - in either case, non-trivial computed configuration could cause problems if the apps are not restarted




