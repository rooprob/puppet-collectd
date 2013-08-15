#####
# This plugin configures the interface-plugin of collectd.
#####

class collectd::plugin::interface ($interfaces=false){

  collectd::plugin::include{"interface":
    pluginsection   => "false",
  }


  # empty interfaces will default to all interfaces, otherwise we can support
  # individually enumerated interfaces

  if $interfaces {
    collectd::plugin::section{ "interface_${name}":
      plugin => "interface",
      startprio => 100,
      endprio => 900
    }
    iface{$interfaces:}
  }

  define iface() {
    Collectd::Plugin::Confline { order   => 200, plugin  => "interface" }
    collectd::plugin::confline{"interface_${name}":
      content => "  Interface \"${title}\""
    }
  }
} # class collectd::plugin::interface
