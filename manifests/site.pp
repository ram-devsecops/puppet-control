## site.pp ##


case $operatingsystem {
  'windows': {
    Package { provider => chocolatey, }
  }
}

hiera_include('roles')
