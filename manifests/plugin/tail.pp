#####
#####

class collectd::plugin::tail(){

  collectd::plugin::include{"tail":
    pluginsection => "true",
  }

  define logfile() {
    $_name = regsubst($title,'[/\.]', '1', 'G')

    collectd::plugin::confline{"tail_${_name}0header":
      plugin  => "tail",
      content => "<File \"$title\">",
    }
    collectd::plugin::confline{"tail_${_name}~footer":
      plugin  => "tail",
      content => "</File>",
    }
  }

  define match($dstype, $type, $regex, $ex_match = '') {

    $filename_and_instance = split($name, ':')
    $logfile = $filename_and_instance[0]
    $instance = $filename_and_instance[1]

    if (defined(Collectd::Plugin::Tail::Logfile[$logfile]) == false) {
      collectd::plugin::tail::logfile{$logfile:}
    }

    $_title = regsubst($title, '[\:\.\[\]\<\>/\+\*\\\(\)\s|]+', '1', 'G')
    collectd::plugin::confline{"tail_${_title}_220_start":
      plugin  => "tail",
      content => "  <Match>",
    }
    collectd::plugin::confline{"tail_${_title}_225_regex":
      plugin  => "tail",
      content => "    Regex \"${regex}\"",
    }

    if ($ex_match != '') {
      collectd::plugin::confline{"tail_${_title}_225_exregex":
        plugin  => "tail",
        content => "    ExcludeRegex \"$ex_match\"",
      }
    }

    collectd::plugin::confline{"tail_${_title}_225_dstype":
      plugin  => "tail",
      content => "    DSType \"$dstype\"",
    }
    collectd::plugin::confline{"tail_${_title}_225_type":
      plugin  => "tail",
      content => "    Type \"$type\"",
    }
    collectd::plugin::confline{"tail_${_title}_225_instance":
      plugin  => "tail",
      content => "    Instance \"$instance\"",
    }
    collectd::plugin::confline{"tail_${_title}_230_end":
      plugin  => "tail",
      content => "  </Match>",
    }
  }

  # Optimised version of match(), reducing the total number of manifest
  # objects created, transmitted and parsed by puppet agent.
  define match_block($config_block) {

    $filename_and_instance = split($name, ':')
    $filename = $filename_and_instance[0]
    $instance = $filename_and_instance[1]

    if (defined(Collectd::Plugin::Tail::Logfile[$filename]) == false) {
      collectd::plugin::tail::logfile{ $filename: }
    }
    # Template uses $config_block and $instance
    collectd::plugin::conf_block{ "tail_${title}":
      plugin  => "tail",
      content => template("collectd/config_blocks/tail.erb"),
    }

  }


} # class collectd::plugin::iptables
