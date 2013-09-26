class hubot {
  $node_prereqs = ['python-software-properties', 'python', 'g++', 'make']
  package {$node_prereqs:
    ensure => "installed",
  }
  
  file {'/home/vagrant/local':
    ensure => "folder",
    owner=>'vagrant',
  }
  
  package { 'git':
    ensure=>present,
  }
  
  exec {'clone node':
    command => "git clone git://github.com/joyent/node.git",
    cwd => '/home/vagrant/',
    user=>'vagrant',
    creates=>'/home/vagrant/node',
    require=>Package['git']
  }
  
  exec {'configure node':
    command => 'python /home/vagrant/node/configure',
    user=>'vagrant',
    require => [Exec['clone node'], File['/home/vagrant/local']]
  }
  exec {'make node':
    command => 'make install',
    cwd => '/home/vagrant/node',
    require => Exec['configure node'],
    timeout => 0,
  }
  
  package { 'npm':
    ensure  => present,
    before => [Exec['install-coffee-script']],
  }
  
  $hubot_prereqs = ['build-essential', 'libssl-dev', 'git-core', 'redis-server', 'libexpat1-dev']
  package {$hubot_prereqs: 
    ensure => present,
  }
  
  exec {'install-coffee-script':
    command => "npm  -g install coffee-script",
  }
  
  file{ '/etc/init/hubot.conf':
    ensure=>file,
    content=>template('hubot/hubot.conf.erb'),
  }
  
  file { '/etc/init.d/hubot':
    ensure => link,
    target => '/lib/init/upstart-job',
  }
  
  user { 'hubot':
    ensure=>present,
  }
  
  service {'hubot':
    ensure => running,
    provider => 'upstart',
    require => File['/etc/init.d/hubot']
  }
}
