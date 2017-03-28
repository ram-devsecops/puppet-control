# Deals with the Puppet Master
class profile::puppetmaster {
  # Wait until we have installed the stuff first before including this class
  if puppetdb_query('resources { type = "Package" and title = "puppetclassify_agent" }').count > 0 {
    include profile::puppetmaster::tuning
  }

  $server_gems = [
    'puppetclassify',
    'retries',
  ]

  $server_gems.each |$gem| {
    package { "${gem}_server":
      ensure   => present,
      name     => $gem,
      provider => 'puppetserver_gem',
      notify   => Service['pe-puppetserver'],
    }

    package { "${gem}_agent":
      ensure   => present,
      name     => $gem,
      provider => 'puppet_gem',
      notify   => Service['pe-puppetserver'],
    }
  }

  # Make sure that a user exists for me
  rbac_user { 'Bond':
    ensure       => 'present',
    display_name => 'James Bond',
    email        => 'james.bond@puppet.com',
    password     => 'puppetlabs',
    roles        => [ 'Administrators' ],
  }

  # Create a Developers role
  rbac_role { 'Developers':
    ensure      => 'present',
    description => 'Can run Puppet, deploy code and use PuppetDB',
    permissions => [
      {
        'action'      => 'run',
        'instance'    => '*',
        'object_type' => 'puppet_agent'
      }, {
        'action'      => 'modify_children',
        'instance'    => '*',
        'object_type' => 'node_groups'
      }, {
        'action'      => 'edit_child_rules',
        'instance'    => '*',
        'object_type' => 'node_groups'
      }, {
        'action'      => 'deploy_code',
        'instance'    => '*',
        'object_type' => 'environment'
      }, {
        'action'      => 'accept_reject',
        'instance'    => '*',
        'object_type' => 'cert_requests'
      }, {
        'action'      => 'edit_params_and_vars',
        'instance'    => '*',
        'object_type' => 'node_groups'
      }, {
        'action'      => 'edit_classification',
        'instance'    => '*',
        'object_type' => 'node_groups'
      }, {
        'action'      => 'view',
        'instance'    => '*',
        'object_type' => 'node_groups'
      }, {
        'action'      => 'view_data',
        'instance'    => '*',
        'object_type' => 'nodes'
      }, {
        'action'      => 'view',
        'instance'    => '*',
        'object_type' => 'console_page'
      }, {
        'action'      => 'set_environment',
        'instance'    => '*',
        'object_type' => 'node_groups'
      }
    ],
  }

  # Import all exported console users
  Console::User <<| |>>

  # Configure default color scheme for puppetmaster logs
  file_line { 'log4j_color_puppetlogs':
    ensure  => present,
    path    => '/etc/multitail.conf',
    line    => 'scheme:log4j:/var/log/puppetlabs/',
    after   => 'default colorschemes',
    require => Package['multitail'],
  }

  /*node_group { 'PE Master':
    ensure               => 'present',
    classes              => {'pe_repo' => {}, 'pe_repo::platform::el_7_x86_64' => {}, 'pe_repo::platform::windows_x86_64' => {}, 'puppet_enterprise::profile::master' => {'enable_future_parser' => false}, 'puppet_enterprise::profile::master::mcollective' => {}, 'puppet_enterprise::profile::mcollective::peadmin' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'PE Infrastructure',
    rule                 => ['or', ['=', 'name', 'master.devops']],
  }*/
}
