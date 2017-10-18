#
class techyfriday_profile::demo::puppetmaster (
  String $puppetdb_listen_address   = 'puppetmaster.example.com',
  String $puppetboard_puppetdb_host = $puppetdb_listen_address,
  String $puppetboard_vhost_name    = $puppetdb_listen_address,
){

  tag 'techyfriday_profile_demo_puppetmaster'

  class { 'puppetdb':
    listen_address  => $puppetdb_listen_address,
    manage_firewall => false,
  }

  class { 'puppetdb::master::config':
    manage_report_processor => true,
    enable_reports          => true,
  }

  # Configure Apache on this server
  class { 'apache':
    purge_configs => true,
    mpm_module    => 'prefork',
    default_vhost => true,
    default_mods  => false,
  }

  class { 'apache::mod::wsgi': }

  # Configure Puppetboard
  class { 'puppetboard':
    puppetdb_host     => $puppetboard_puppetdb_host,
    manage_git        => true,
    manage_virtualenv => false,
  }

  # Access Puppetboard through
  class { 'puppetboard::apache::vhost':
    vhost_name => $puppetboard_vhost_name,
    port       => 80,
  }

}
