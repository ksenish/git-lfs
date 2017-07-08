class envvars {
	file { 'bash_profile':
		path		=> '/home/vagrant/.bash_profile',
		owner		=> 'vagrant',
		group		=> 'vagrant',
		mode		=> '644',
		source		=> "puppet:///modules/envvars/bash_profile",
	}
}
