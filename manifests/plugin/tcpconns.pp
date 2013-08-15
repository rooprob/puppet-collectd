#####
# This class configures the tcpconns-plugin of collectd.
#####

class collectd::plugin::tcpconns() {
  collectd::plugin::include{"tcpconns":
    pluginsection   => "true",
  }

  define listening_ports ($listening_ports = "false") {
    collectd::plugin::confline{"222_tcpconns_listening_ports":
      order   => 222,
      plugin  => "tcpconns",
      content => "ListeningPorts ${listening_ports}",
    }
  }

  define service($local_port  = "80", $remote_port  = "") {
    if $local_port != "" {
      collectd::plugin::confline{"222_tcpconns_local_port_${title}_${local_port}":
        order   => 222,
        plugin  => "tcpconns",
        content => "LocalPort \"${local_port}\"",
      }
    }
    if $remote_port != "" {
      collectd::plugin::confline{"222_tcpconns_remote_port_${title}_${remote_port}":
        order   => 222,
        plugin  => "tcpconns",
        content => "RemotePort \"${remote_port}\"",
      }
    }
  }
} # class collectd::plugin::tcpconns
