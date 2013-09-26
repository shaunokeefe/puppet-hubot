puppet-hubot
============

Simple module to set up a hubot

Will set up nodejs, npm and other requirements for hubot ready for you to check out a local
copy of Hubot/ install it from npm and run it with campfire. Will also start running upstart.

Include something like the following in your node

$hubot_campfire_account='<account name>' # the one in: <companyname>.campfirenow.com  
$hubot_campfire_rooms='<room id>' # this will be in the url when you open up the room 
$hubot_campfire_token='<very large collection of characters>'  
$hubot_dir='/home/user/hubot/' # The directory Hubot is checked out in  
$hubot_cmd='bin/hubot' # The command to run Hubot  
$hubot_adapter='campfire' # The adapter to use  
$hubot_user='hubot' # User to run Hubot as  
$hubot_name='hubot' # The name Hubot will listen as  
$hubot_port='5555'  

include hubot
