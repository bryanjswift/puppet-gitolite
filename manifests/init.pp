# == Class: gitolite
#
# This is the gitolite module. It installs [gitolite](http://sitaramc.github.com/gitolite)
# from source by cloning the gitolite code and automating the installation process.
# This module is not for managing repositories in gitolite, you should clone the
# gitolite-admin repository from your host and edit the files there to do that.
#
# === Parameters
#
# Document parameters here.
#
# [*admin_name*]
#   Name of the user to make the admin
#
# [*admin_pub_src*]
#   Path to use as source for the *admin_name*'s public key
#
# [*admin_pub_content*]
#   Content of file to use as *admin_name*'s public key. This takes precedence
#   over *admin_pub_src*.
#
# [*src*]
#   Location where gitolite source should be cloned from.
#   Defaults to `git://github.com/sitaramc/gitolite`
#
# [*user*]
#   User to be created on the server to be used when accessing the repositories
#   via ssh.
#   Defaults to `gitolite`
#
# [*user_home*]
#   Directory to be created and used as *user*'s home directory.
#   Defaults to `/home/gitolite`
#
# === Examples
#
#   class { gitolite:
#     admin_name    => "joe_smith",
#     admin_pub_src => "/home/joe_smith/joe_smith.pub",
#   }
#
# === Authors
#
# Bryan J Swift <bryan.j.swift@gmail.com>
#
# === Copyright
#
# Copyright 2012 Bryan J Swift
#
class gitolite(
  $admin_name        = "admin",
  $admin_pub_src     = "",
  $admin_pub_content = "",
  $src               = 'git://github.com/sitaramc/gitolite',
  $user              = 'gitolite',
  $user_home         = '/home/gitolite',
) {

  if ($gitolite::admin_pub_content == "" and $gitolite::admin_pub_src == "") {
    fail("No source or content for admin key")
  }

  include gitolite::user, gitolite::install

}
