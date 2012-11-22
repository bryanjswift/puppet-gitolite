class gitolite::install {

  include git # require git module, this is a dependency defined in Modulefile

  exec { "Download Source":
    command => "git clone ${gitolite::src} gitolite",
    creates => "${gitolite::user_home}/gitolite",
    cwd     => "${gitolite::user_home}",
    require => [Class["gitolite::user"]],
  }

  exec { "Install Gitolite":
    command => "./install -ln",
    creates => "${gitolite::user_home}/.gitolite",
    cwd     => "${gitolite::user_home}/gitolite",
    require => [Exec["Download Source"]],
    user    => "${gitolite::user}",
  }

  file { "Initial Key":
    content => $gitolite::admin_pub_content,
    ensure  => present,
    group   => "${gitolite::user}",
    name    => "${gitolite::user_home}/${gitolite::admin_name}.pub",
    user    => "${gitolite::user}",
  }

  exec { "Setup Gitolite":
    command => "gitolite setup -pk ${gitolite::user_home}/${gitolite::admin_name}.pub",
    creates => "${gitolite::user_home}/repositories/gitolite-admin.git",
    cwd     => "${gitolite::user_home}",
    path    => ["${gitolite::user_home}/bin", "/usr/bin"],
    require => [Exec["Install Gitolite"]],
    user    => "${gitolite::user}",
  }

}
