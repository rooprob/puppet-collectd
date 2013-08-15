define collectd::config_block($config_block,
  $owner='root',
  $group='root',
  $mode='0700',
  $order='100',
  $load_plugin=true,
  $template='collectd/config_blocks/generic.erb'
) {

  $filename_and_instance = split($name, ':')
  $filename = $filename_and_instance[0]
  $instance = $filename_and_instance[1]

  if (defined(Concat[$filename]) == false) {
    concat { $filename:
      owner => $owner,
      group => $group,
      mode  => $mode,
    }
  }

  concat::fragment { $instance:
    target  => $filename,
    order   => $order,
    content => template($template)
  }

}
