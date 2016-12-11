class omamoduuli {
	package {apache2:
		ensure => "installed",
		allowcdrom => "true",
	}
 
	package {libreoffice:
		ensure => "installed",
		allowcdrom => "true",
	}

	package {gedit:
		ensure => "installed",
		allowcdrom => "true",
	}

	file { "/etc/skel/public_html":
		ensure => "directory",
	}

	file { '/etc/apache2/mods-enabled/userdir.conf':
		ensure => 'link',
		target => '../mods-available/userdir.conf',
		notify => Service["apache2"],
		require => Package["apache2"],
	}

	file { '/etc/apache2/mods-enabled/userdir.load':
		ensure => 'link',
		target => '../mods-available/userdir.load',
		notify => Service["apache2"],
		require => Package["apache2"],
	}

	service {"apache2":
		ensure => "true",
		enable => "true",
		require => Package["apache2"],
	}
}
