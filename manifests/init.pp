class omamoduuli {
	Package {ensure => "installed", allowcdrom => "true",}
	package {"apache2":}
	package {"php7.0":}
	package {"gedit":}
	package {"libreoffice":}
	package {"ssh":}
	package {"git":}
	package {"mysql-client":}
	package {"mysql-server":}
	package {"libapache2-mod-php":
		require => Package ["apache2"],}

	file { "/etc/motd":
		ensure => 'link',
		target => "/var/run/motd",	
	}

	file { "/var/run/motd":
		ensure => present,
		content => "Tervetuloa!\n",
	}

	file { "/etc/skel/public_html":
		ensure => "directory",
	}

	file { "/etc/skel/public_html/index.php":
		content => template("omamoduuli/index.php"),
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

	file {"/etc/apache2/mods-available/php7.0.conf":
		content => template("omamoduuli/php7.0.conf"),
		notify => Service ["apache2"],
	}

	service {"apache2":
		ensure => "true",
		enable => "true",
		require => Package["apache2"],
	}
}
