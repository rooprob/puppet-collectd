#####
# This class configures processes
#####

class collectd::plugin::processes() {

  collectd::plugin::include{"processes":
    pluginsection => "true",
  }

  define process() {
    concat_fragment { "222_${title}_222":
      order   => 222,
      target  => "${collectd::conf_path}/plugins/processes.conf",
      content => inline_template("Process \"${title}\"\n"),
    }
  }
} # class collectd::plugin::processes
