class ssh_kcc (
  $dynamic_motd = true,
  $template = undef,
  $content = undef,
) {

  if $template {
    if $content {
        warning('Both $template and $content parameters passed to motd, ignoring content')
    }
    $motd_content = template($template)
  } elsif $content {
    $motd_content = $content
  } else {
    $motd_content = template('ssh_kcc/motd.erb')
  }

  if $::kernel == 'Linux' {
    file { '/etc/motd':
      ensure  => file,
      backup  => false,
      content => $motd_content,
    }

  }
}