class mymodule {
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

	file { "/etc/skel/public_html":
		ensure => "directory",
	}

	file { "/etc/skel/public_html/index.php":
		content => template("mymodule/index.php"),
	}
	
	file {"/var/www/html/index.html":
		content => "Hei maailma!\n",
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
		content => template("mymodule/php7.0.conf"),
		notify => Service ["apache2"],
		require => Package["apache2", "php7.0", "libapache2-mod-php"],
	}

	service {"apache2":
		ensure => "true",
		enable => "true",
		require => Package["apache2"],
	}
}
