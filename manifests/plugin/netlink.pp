#####
# This plugin configures the netlink-plugin of collectd.
#####

class collectd::plugin::netlink (
    $verbose_interface  = "All",
){

  collectd::plugin::include{"netlink":
    pluginsection   => "false",
  }

  collectd::plugin::section{ "netlink":
    plugin => "netlink",
    startprio => 222,
    endprio => 222
  }
  Collectd::Plugin::Confline { order   => 222, plugin  => "netlink" }
  collectd::plugin::confline{"netlink_interface":
    content => "  VerboseInterface \"${verbose_interface}\""
  }
} # class collectd::plugin::netlink
