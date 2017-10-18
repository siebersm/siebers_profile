#
#
class techyfriday_profile::initial::initial {

  tag 'techyfriday_profile_initial_initial'

  notify { 'Initial message':
    message => "
Hi Admin, this server is running at the 'initial' application_name/role.
Please move this server to:

application_name: 'demo'
application_role: 'quest1'

and do some puppet runs (like 2 times) to make sure this server stays at his new application name/role\n\n",
  }

}
