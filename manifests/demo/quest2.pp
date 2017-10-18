#
class techyfriday_profile::demo::quest2 (
  String           $directory      = 'data',
  String           $file_name      = 'info.txt',
  Optional[String] $file_parameter = undef,

){

  case $::facts['os']['family'] {
    'RedHat': {   $_directory = "/${directory}" }
    'windows': {  $_directory = "c:/${directory}"}
    default: {    fail("Sorry ${::facts['os']['family']} is not supported")}
  }

  file { $_directory:
    ensure => directory,
  }

  if ($directory == 'data') {

    notify { 'Directory data':
      message => "
Welcome at quest2!

This application_name is creating a directory '${_directory}' on this server.\n
Your next task is to change this directory name to 'storage' via a hiera setting at a level that is environment independend.\n
\n",
    }

  }

  elsif ($directory == 'storage') {

    if ($file_parameter == undef) {
      notify { 'Directory storage':
        message => "
Perfect you changed the directory name to ${_directory} as requested.\n
This puppet run now created a file in ${_directory} called ${file_name}.\n
In this file you can find some information but you can also adjust a parameter called 'file_parameter'\n
Change this setting to any string that you want.\n\n",
      }
    } else {

      if ($::facts['customer_environment'] == 'production') {

        notify { 'Directory storage with parameter':
          message => "
Well done! you have changed the file_parameter setting to '${file_parameter}'.

To see the real power of hiera make a yaml file with different settings for the
acceptance environment and after that change the customer_environment to acceptance for this server.
",
        }

      }

      if ($::facts['customer_environment'] == 'acceptance') {

        notify { 'Directory storage with parameter':
          message => "
Well done! you have changed the file_parameter setting to '${file_parameter}' in the customer environment '${facts['customer_environment']}'.

Because the environment specific settings are found before the general settings you see that puppet is using these.\n

This is the end of the demo.

Thank you and I hope you learned something!

",
        }

      }



    }

    file { "${_directory}/${file_name}":
      ensure  => file,
      require => File[$_directory],
      content => "
# This file is manged by Puppet

This file is for customer ${::facts['customer_name']} and build in the environment ${::facts['customer_environment']}\n
\n
The server specs are:\n
Total memory:           ${::facts['memory']['system']['total']}\n
Number of CPU's:        ${::facts['processors']['physicalcount']}\n
Number of CPU's cores:  ${::facts['processors']['count']}\n
CPU type:               ${::facts['processors']['models'][0]}\n
\n
Current value of file_parameter is: ${file_parameter}\n
\n";
    }

  }
}
