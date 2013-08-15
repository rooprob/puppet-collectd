#####
# This class activates and configures a special plugin for collectd. Some plugins need a special
# configuration. Therefor we put some classes in the plugin directory.
#####

class collectd::plugin {


  define include (
    $pluginsection  = "false",
    $extra_content = false
  ) {
    include collectd
    # Config-file of the plugin that contain all configurations of a special plugin
    concat{ "${collectd::conf_path}/plugins/${name}.conf":
      notify  => Service['collectd'],
      require => Package["collectd"],
      mode    => '0400',
      owner   => root,
      group   => root,
    }

    if $extra_content == false {
      /* Easy plugin-loading via LoadPlugin-row */
      concat::fragment { "000_${name}_load":
        order   => 000,
        target  => "${collectd::conf_path}/plugins/${name}.conf",
        content => inline_template("LoadPlugin \"${name}\" \n"),
        #require => Concat["${collectd::conf_path}/plugins/${name}.conf"],
      }
    } else {
        /* creates <LoadPlugin XYZ>-section */
        concat::fragment { "000_${name}_load":
          order   => 000,
          target  => "${collectd::conf_path}/plugins/${name}.conf",
          content => inline_template("<LoadPlugin ${name}>\n${extra_content}\n</LoadPlugin>\n"),
          #require => Concat["${collectd::conf_path}/plugins/${name}.conf"],
        }
    }
    /* create plugin-Section, if need */
    if $pluginsection == "true" {
      section { "${name}": plugin => "${name}" }
    }
  } # define include

  #
  # creates a new <Plugin ... >-section
  #
  define section ($plugin,$startprio=111,$endprio=999) {
    include collectd
    concat::fragment { "${startprio}_${name}_0header":
      order   => $startprio,
      target  => "${collectd::conf_path}/plugins/${plugin}.conf",
      content => inline_template("<Plugin \"${plugin}\"> \n"),
      #require => Concat["${collectd::conf_path}/plugins/${plugin}.conf"],
    }
    concat::fragment { "${endprio}_${name}_~footer":
      order   => $endprio,
      target  => "${collectd::conf_path}/plugins/${plugin}.conf",
      content => inline_template("</Plugin> \n"),
      #require => Concat["${collectd::conf_path}/plugins/${plugin}.conf"],
    }
  } # define section

  define confline (
    $plugin,
    $order="200",
    $content
  ){
    include collectd
    concat::fragment { "${order}_${name}":
      order   => $order,
      target  => "${collectd::conf_path}/plugins/${plugin}.conf",
      content => inline_template("${content}\n"),
      #require => Concat["${collectd::conf_path}/plugins/${plugin}.conf"],
    }
  } # define confline

  # Optimisation to reduce the total number of objects created for a confline
  # fragment
  define conf_block (
    $plugin,
    $order="200",
    $content,
  ) {
    $safename = regsubst($name, '[\:\.\[\]\<\>/\+\*\\\(\)\s|]+', '1', 'G')
    concat::fragment { "${order}_${safename}":
      order  => $order,
      target => "${collectd::conf_path}/plugins/${plugin}.conf",
      content => $content,
    }
  }


} # class collectd::plugin
