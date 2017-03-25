class profile::slave {

  case $::osfamily {
    redhat: {

      class { 'docker':
        version => 'latest',
      }

      class { "maven::maven":
        version => "3.2.5",
      }

      class { '::jenkins::slave':
         masterurl => 'http://jenkins.devops/',
         ui_user => 'jenkins',
         ui_pass => 'jenkins',
       }
    }

    windows: {

      include ::chocolatey

      package { 'nodejs':
        ensure   => present,
        provider => 'chocolatey',
      }

      package { 'maven':
        ensure   => present,
        provider => 'chocolatey',
      }

      package { 'firefox':
        ensure   => present,
        provider => 'chocolatey',
      }

      package { 'googlechrome':
        ensure   => present,
        provider => 'chocolatey',
      }

      class { 'jenkins_windows_agent':
        jenkins_master_url  => 'http://jenkins.devops/',
        jenkins_master_user => 'jenkins',
        jenkins_master_pass => 'jenkins',
      }

    }
  }
}
