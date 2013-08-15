#####
# This class configures the disk-plugin of collectd.
#####

class collectd::plugin::disk ($ignoreselected = "false"){
  collectd::plugin::include{"disk":
    pluginsection   => "true",
  }
  collectd::plugin::confline{"222_disk":
    order   => 222,
    plugin  => "disk",
    content => "IgnoreSelected ${ignoreselected}",
  }

  define device() {
    $_title = regsubst($title, '[\:\.\[\]\<\>/\+\*\\\(\)\s|]+', '1', 'G')

    collectd::plugin::confline{"222_disk_device_${_title}":
      order   => 222,
      plugin  => "disk",
      content => "Disk \"${title}\"",
    }
  }
} # class collectd::plugin::disk
