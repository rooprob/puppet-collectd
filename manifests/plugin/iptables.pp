#####
# This class configures the iptables-plugin of collectd.
#####

class collectd::plugin::iptables (){
  collectd::plugin::include{"iptables":
    pluginsection   => "true",
  }

  define counter($table, $comment) {
    concat_fragment { "222_${table}_${title}_222":
      order   => 222,
      target  => "${collectd::conf_path}/plugins/iptables.conf",
      content => inline_template("Chain ${table} ${comment}\n"),
    }
  }
  define io_counter() {
    $in_table = "incoming"
    $out_table = "outgoing"

    counter{"${in_table}_${title}":
      table   => $in_table,
      comment => $title,
    }
    counter{"${out_table}_${title}":
      table   => $out_table,
      comment => $title,
    }
  }
} # class collectd::plugin::iptables
