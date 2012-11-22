class gitolite::user {

  File {
    ensure  => directory,
    group   => $gitolite::user,
    owner   => $gitolite::user,
    mode    => 0755,
  }

  file { "home_dir":
    path    => $gitolite::user_home,
    require => [User["gitolite_user"]],
  }

  file { "home_dir_ssh":
    path    => "${gitolite::user_home}/.ssh",
    require => [File["home_dir"]],
  }

  file { "home_bash_rc":
    content => template("gitolite/bashrc.erb"),
    ensure  => present,
    mode    => 0644,
    path    => "${gitolite::user_home}/.bashrc",
    require => [File["home_dir"]],
  }

  file { "home_bin":
    path    => "${gitolite::user_home}/bin",
    require => [File["home_dir"]],
  }

  group { "gitolite_group":
    name   => $gitolite::user,
    ensure => present,
  }

  user { "gitolite_user":
    comment => "User for gitolite interaction",
    home    => $gitolite::user_home,
    gid     => $gitolite::user,
    name    => $gitolite::user,
    shell   => "/bin/bash",
  }

}
