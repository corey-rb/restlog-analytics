Restlog
=======


Data API
---------

POST:

> Required Parameters


Name			          |  Value 		| Example
-------  |	----
Restlog[app_key] |  The Unique App Key | 70H9uC61UJTlF1I2Ik8DjA |
Restlog[api_key] | User's Restlog API Key | oX438Thrs09483jgks |
message[event] | JSON Event Data Object | {   "levels": [     1,     2,     3   ],   "canFail": true,   } |
message[level] | Level of message, defined by app on what it saves


Change log
-----------------
v0.3.3
-----
* MessageCollections - renamed propertes for criteria_value and collection_criteria_property
* App -> View -> Save message collection integrated.  Added validation.  
* App -> View -> When saving a colleciton it auto populates the Collection drop down search criteria

v0.3.2
-----
Readme additions

v0.3.1
-----
* MessageCollectionsController now supports saving, and retrieving
* App JSON.RABL template now includes the serialzation of the message collections
* Start of UI for message collections integrated on AppView angular template

v0.3.0
----
* removed obsolete fields, short_description and long_description from Message.rb
* mongid 5.0.0 update
* add MessageCollection.rb model
* added MessageCollection rabl views, MessageCollectionsController.rb, messages/collections routes.


v0.2.4 - develop (merged in master)
--------
* added traits to spec/factories/signup_key.rb
* fixed user_signup_spec.rb to work with new validiation
* added flash messages (errors) to devise/registraiton/new.html.erb page for failed beta key, and missing beta key
* added version to config.masterctrl.js to be displayed in footer
* removed templates/restlog/dashboard.html.erb (unneeded)

v0.2.3
----
* renamed angular/controller/app_managment.js to /app_controller.js
* added jasmine gems and initial framework for testing

v0.2.2
----
* added jasmine to Gemfile
* removed fastercsv from Gemfile
* initial jasmine initilazations added

v0.2.1
-----
* rails updates from '4.2.1' to '4.2.3'
* angular updated to 1.4
* removed ngstorage
* removed bootstrap from bower config
* angular cookies, resource, touch sanitize updated from 1.3 to 1~.4

v0.1.4
-----
* angular service added, Messages.js, for handling filtering of messages by app
* start_date, end_date filtering added to messages_controlller.rb


v0.1.3
------
* removed chartkick gem
* added congif driven version to angular template, in footer
* renamed messages_controlelr#index route to /app/message?app_id=XXXX

v0.1.2
------
* Gems added for pry, pry-doc, pry-byebug
* MessagesController#index returns paged results per appid supplies

v0.1.1
-----
* refacotring and rebuilding messages api and controller


v0.1.0
-----
* removed all references to pulsar, renamed to restlog and Restlog
* removed old message_analytics.rb actions
* removed all old routes from routes.rb pertaining to above mentioned code refacotring
* added version to application.rb
