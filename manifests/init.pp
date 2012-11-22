# == Class: gitolite
#
# Full description of class gitolite here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Examples
#
#  class { gitolite:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
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

  include gitolite::install

}
