#####
# This class is for a collectd client. There are some plugins loaded,
# that we see to be needed for a collectd-client.
#####

class collectd::client (
  $server_ip,
  $port = "25826",
  $syslog_loglevel = "info"
){
  include collectd
  class {"collectd::plugin::network":
    server_ip => $server_ip,
    client    => "true",
    port      => $port,
  }

  include collectd::plugin::tail

  $prefix = "mytestapp"
  $prefix2 = "mytestapp2"
  collectd::plugin::tail::match_block{ "/var/log/syslog:${prefix}":
    config_block => [
      {
        regex    => ".*",
        dstype   => 'CounterInc',
        type     => 'counter',
        instance => "${prefix}_requests",
      },
      {
        regex    => "Exception ",
        dstype   => 'CounterInc',
        type     => 'counter',
        instance => "${prefix}_exceptions",
      },
    ]
  }
  collectd::plugin::tail::match_block{ "/var/log/syslog:${prefix2}":
    config_block => [
      {
        regex    => ".*",
        dstype   => 'CounterInc',
        type     => 'counter',
        instance => "${prefix2}_requests",
      },
      {
        regex    => "Exception ",
        dstype   => 'CounterInc',
        type     => 'counter',
        instance => "${prefix2}_exceptions",
      },
    ]
  }
  collectd::plugin::tail::match_block{ "/var/log/mail:mail":
    config_block => [
      {
        regex    => ".*",
        dstype   => 'CounterInc',
        type     => 'counter',
        instance => "mail_requests",
      },
    ]
  }
#  collectd::plugin::df { "base":
#    config_block   => [
#      {
#        'device'     => '/dev/sda2',
#        'mountpoint' => '/boot',
#        'fstype'     => 'ext4',
#      },
#      {
#        'device'     => '/dev/sda2',
#        'mountpoint' => '/',
#        'fstype'     => 'ext4',
#      },
#    ],
#  }
#
#  collectd::plugin::df { "enterproid":
#    config_block   => [
#      {
#        'device'     => '/enterproid',
#        'mountpoint' => '/enterproid',
#        'fstype'     => 'vboxfs',
#      },
#      {
#        'device'     => '/cfgsvr/hieradata',
#        'mountpoint' => '/cfgsvr/hieradata',
#        'fstype'     => 'vboxfs',
#      },
#    ],
#  }

  class {"collectd::plugin::cpu":}
  class {"collectd::plugin::memory":}
  class {"collectd::plugin::syslog":
    syslog_loglevel => $syslog_loglevel,
  }
  class {"collectd::plugin::load":}
} # class collectd::client
