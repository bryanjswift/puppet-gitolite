class gitolite::install {

  # require git module, this is a dependency defined in Modulefile, provides Class["git"]
  include git

  exec { "Download Source":
    command => "git clone ${gitolite::src} gitolite",
    creates => "${gitolite::user_home}/gitolite",
    cwd     => "${gitolite::user_home}",
    path    => ["/usr/bin", "/usr/local/bin", "/bin"],
    require => [Class["git"], Class["gitolite::user"]],
  }

  exec { "Install Gitolite":
    command     => "install -ln",
    creates     => "${gitolite::user_home}/.gitolite",
    cwd         => "${gitolite::user_home}/gitolite",
    environment => "HOME=${gitolite::user_home}",
    path        => ["${gitolite::user_home}/gitolite"],
    require     => [Exec["Download Source"]],
    user        => "${gitolite::user}",
  }

  if ($gitolite::admin_pub_content != "") {
    file { "Initial Key":
      content => $gitolite::admin_pub_content,
      ensure  => present,
      group   => "${gitolite::user}",
      name    => "${gitolite::user_home}/${gitolite::admin_name}.pub",
      owner   => "${gitolite::user}",
      require => [Class["gitolite::user"]],
    }
  } else {
    file { "Initial Key":
      ensure  => present,
      group   => "${gitolite::user}",
      name    => "${gitolite::user_home}/${gitolite::admin_name}.pub",
      source  => "${gitolite::admin_pub_src}",
      owner   => "${gitolite::user}",
      require => [Class["gitolite::user"]],
    }
  }

  exec { "Setup Gitolite":
    command     => "gitolite setup -pk ${gitolite::user_home}/${gitolite::admin_name}.pub",
    creates     => "${gitolite::user_home}/repositories/gitolite-admin.git",
    cwd         => "${gitolite::user_home}",
    environment => "HOME=${gitolite::user_home}",
    path        => ["${gitolite::user_home}/bin", "/usr/bin"],
    require     => [Exec["Install Gitolite"], File["Initial Key"]],
    user        => "${gitolite::user}",
  }

}
