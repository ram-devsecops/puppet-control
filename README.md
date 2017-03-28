# puppet-control

Installs Puppet Enterprise master server

### Requirements
***

* [Download Vagrant 1.8.6+] (http://www.vagrantup.com/downloads.html)
* [Download Virtualbox 5.1.6+] (http://download.virtualbox.org)
* Install Below Vagrant Plugins
   `vagrant plugin install oscar`
   `vagrant plugin install vagrant-hostmanager`

### Running from this repository

   git clone https://github.com/rammaram06/puppet-control.git
   cd puppet-control
   vagrant up master

### Access the PE Console

  [PE Console](https://master.devops)

  `user: admin`
  `password: puppetlabs`

### Setup Jenkins master

* vagrant up jenkins

  [Jenkins Console](http://jenkins.devops)

### Slaves

* vagrant up slave (Brings up a centos7 vm)

### To bring up windows slave update
* ~/.vagrant.d/gems/2.2.5/gems/vagrant-hostmanager-1.8.5/lib/vagrant-hostmanager/hosts_file/updater.rb file
https://github.com/devopsgroup-io/vagrant-hostmanager/pull/229/files

* vagrant up slavewin (Brings up a win2012r2 vm)

###Note:


Passwordless sudo
-----------------

To avoid being asked for the password every time the hosts file is updated,
enable passwordless sudo for the specific command that hostmanager uses to
update the hosts file.

  - Add the following snippet to the sudoers file (e.g.
    `/etc/sudoers.d/vagrant_hostmanager`):

    ```
    Cmnd_Alias VAGRANT_HOSTMANAGER_UPDATE = /bin/cp <home-directory>/.vagrant.d/tmp/hosts.local /etc/hosts
    %<admin-group> ALL=(root) NOPASSWD: VAGRANT_HOSTMANAGER_UPDATE
    ```

    Replace `<home-directory>` with your actual home directory (e.g.
    `/home/joe`) and `<admin-group>` with the group that is used by the system
    for sudo access (usually `sudo` on Debian/Ubuntu systems and `wheel`
    on Fedora/Red Hat systems).

  - If necessary, add yourself to the `<admin-group>`:

    ```
    usermod -aG <admin-group> <user-name>
    ```

    Replace `<admin-group>` with the group that is used by the system for sudo
    access (see above) and `<user-name>` with you user name.
