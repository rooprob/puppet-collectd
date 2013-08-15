class { collectd:
  conf_path  => '/etc/collectd',
}

collectd::config_block { "${collectd::conf_path}/collectd.conf:extra_1":
  config_block => [
    {
      'extra1_setttings1' => 'bla',
      'extra1_setttings2' => 'bla',
      'extra1_setttings3' => 'bla',
      'extra1_setttings4' => 'bla',
    },
  ],
  order   => "20",
}
collectd::config_block { "${collectd::conf_path}/collectd.conf:extra_2":
  config_block => [
    {
      'extra2_setttings1' => 'bla',
      'extra2_setttings2' => 'bla',
      'extra2_setttings3' => 'bla',
      'extra2_setttings4' => 'bla',
    },
  ],
  order   => "10",
}
