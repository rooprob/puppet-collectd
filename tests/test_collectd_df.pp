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

