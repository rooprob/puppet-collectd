#####
# Collectd Module for puppet
#
# This is the main class of the puppet-collectd module.  It installs and
# configures collectd. It doesn't configure the modules for collectd.  Therefor
# you have to use the other classes.
#####

class collectd(
  # class variables
  $conf_path   = '/etc/collectd',
  $fqdnlookup  = 'true',
  $interval    = '60',
  ){

  # install collectd package
  package { "collectd":
    ensure  => installed,
  }
  # generates collectd service for puppet
  service { "collectd":
    ensure     => running,
    require    => Package['collectd'],
    hasrestart => true,
  }
  # creates the plugin dir, that is used for all other configs of the plugins
  file { $conf_path:
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0700',
    notify  => Service['collectd'],
    require => Package['collectd'],
  }
  file { "${conf_path}/plugins":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0700',
    recurse => true,
    purge   => true,
    force   => true,
    notify  => Service['collectd'],
    require => [
      File[$conf_path],
      Package['collectd'],
    ]
  }
  file { "${conf_path}/local":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0700',
    require => [
      File[$conf_path],
      Package['collectd'],
    ]
  }
  # creates the threasholds dir
  file { "${conf_path}/thresholds":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0700',
    recurse => true,
    purge   => true,
    force   => true,
    notify  => Service['collectd'],
    require => [
      File[$conf_path],
      Package['collectd'],
    ]
  }

  # create a object single update for main config
  collectd::config_block { "${conf_path}/collectd.conf:main":
    load_plugin  => false,
    config_block => [
      {
        'fqdnlookup' => $fqdnlookup,
        'interval'   => $interval,
        'include'    => [
          "\"${conf_path}/plugins/*.conf\"",
          "\"${conf_path}/local/*.conf\""
        ]
      },
    ],
    notify  => Service['collectd'],
  }

  Collectd::Config_block {
    require => [
      File[$conf_path],
      Package['collectd'],
    ],
  }
} # class collectd
