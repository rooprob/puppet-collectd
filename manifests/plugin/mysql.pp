#####
#####

class collectd::plugin::mysql(){

  collectd::plugin::include{"mysql":
    pluginsection => "true",
  }

  define database($user='', $passwd='', $hostname='',
                  $port='3306', $socket='',
                  $masterstats='false', $slavestats='false',
                  $slavenotifications='false') {

    collectd::plugin::confline{"mysql_${_title}0header":
      plugin  => "mysql",
      content => "<Database \"$title\">",
    }
    collectd::plugin::confline{"mysql_${_title}~footer":
      plugin  => "mysql",
      content => "</Database>",
    }

    if ($socket == '' and $hostname == '') {
      fail("database monitor requires either socket or hostname")
    }
    if ($socket == '') {
      collectd::plugin::confline{"mysql_${_title}_220_hostname":
        plugin  => "mysql",
        content => "Host \"${hostname}\"",
      }
      if ($port != '') {
        collectd::plugin::confline{"mysql_${_title}_220_port":
          plugin  => "mysql",
          content => "Port ${port}",
        }
      }
    } else {
      collectd::plugin::confline{"mysql_${_title}_220_socket":
        plugin  => "mysql",
        content => "Socket \"${socket}\"",
      }
    }
    if ($user != '') {
      collectd::plugin::confline{"mysql_${_title}_220_user":
        plugin  => "mysql",
        content => "User \"${user}\"",
      }
    }
    if ($passwd != '') {
      collectd::plugin::confline{"mysql_${_title}_220_passwd":
        plugin  => "mysql",
        content => "Password \"${passwd}\"",
      }
    }
    if ($masterstats != '') {
      collectd::plugin::confline{"mysql_${_title}_220_masterstats":
        plugin  => "mysql",
        content => "MasterStats ${masterstats}",
      }
    }
    if ($slavestats != '') {
      collectd::plugin::confline{"mysql_${_title}_220_slavestats":
        plugin  => "mysql",
        content => "SlaveStats \"${slavestats}\"",
      }
    }
    if ($slavenotifications != '') {
      collectd::plugin::confline{"mysql_${_title}_220_slavenotifications":
        plugin  => "mysql",
        content => "SlaveNotifications \"${slavenotifications}\"",
      }
    }
  }
}
