#####
# This class configures the ethstat-plugin of collectd.
#####

class collectd::plugin::ethstat (){
  collectd::plugin::include{"ethstat":
    pluginsection   => "true",
  }
  define interface(){
    collectd::plugin::confline{"222_ethstat_interface_${title}":
      order   => 222,
      plugin  => "ethstat",
      content => "Interface \"${title}\"",
    }
    collectd::plugin::confline{"222_ethstat_map_${title}":
      order   => 222,
      plugin  => "ethstat",
      content => 'Map "rx_csum_offload_errors" "if_rx_errors" "checksum_offload" "multicast" "if_multicast"',
    }
  }
} # class collectd::plugin::ethstat
