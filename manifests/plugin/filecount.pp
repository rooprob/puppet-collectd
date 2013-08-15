class collectd::plugin::filecount(){

  collectd::plugin::include{"filecount":
    pluginsection => "true",
  }

  define instance($instance, $pattern=false, $mtime='', $size='', $recursive=true, $hidden=false) {

    $_name = regsubst($title,'[/\.]', '1', 'G')
    collectd::plugin::confline{"filecount_${_name}0header":
      plugin  => "filecount",
      content => "<Directory \"$title\">",
    }
    collectd::plugin::confline{"filecount_${_name}~footer":
      plugin  => "filecount",
      content => "</Directory>",
    }

    collectd::plugin::confline{"filecount_${_name}200":
      plugin  => "filecount",
      content => "Instance ${instance}",
    }
    if $pattern {
      collectd::plugin::confline{"filecount_${_name}200":
        plugin  => "filecount",
        content => "Name ${pattern}",
      }
    }
    if $mtime {
      collectd::plugin::confline{"filecount_${_name}200":
        plugin  => "filecount",
        content => "MTime ${mtime}",
      }
    }
    if $size {
      collectd::plugin::confline{"filecount_${_name}200":
        plugin  => "filecount",
        content => "Size ${size}",
      }
    }
    if $recursive == false {
      # true by default
      collectd::plugin::confline{"filecount_${_name}200":
        plugin  => "filecount",
        content => "Recursive false",
      }
    }
    if $hidden == true {
      # false by default
      collectd::plugin::confline{"filecount_${_name}200":
        plugin  => "filecount",
        content => "IncludeHidden true",
      }
    }

  }

} # class collectd::plugin::filecount
