class role::slave {
  case $::osfamily {
    redhat: {
      include profile::base
      include profile::slave
    }
    windows: {
      include profile::base
      include profile::slave
    }
  }
}
