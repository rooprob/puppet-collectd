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

