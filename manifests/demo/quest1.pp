#
class techyfriday_profile::demo::quest1 (){

  notify { 'Initial message':
    message => "
Perfect! You changed the application_name/role to demo/quest1

Now let change the application_name once more to go to your next quest!

application_role: 'quest2'

",
  }
}
