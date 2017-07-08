$pkg_dev_packages = [ "vim", "wget", "gcc", "git",
                    "software-properties-common", "python-software-properties" ]

exec { "apt-get update":
    command => "/usr/bin/apt-get update"
}

package { $pkg_dev_packages:
    ensure => latest,
    require => Exec["apt-get update"]
}

# Set up the timezone inside the VM to match Alameda
exec { "timezone":
    user => "root",
    path => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
    command => "rm /etc/localtime && ln -s /usr/share/zoneinfo/US/Pacific /etc/localtime"
}

exec { "install_golang":
    user => "root",
    path => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
    require => Package["software-properties-common"],
    command => "wget -O /tmp/go.tar.gz https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz && \
      tar -C /usr/local -xzf /tmp/go.tar.gz && \
      rm -rf /tmp/go.tar.gz"
}

exec { "install_glide":
    user => "root",
    require => Exec["install_golang"],
    path => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin", "/usr/local/go/bin" ],
    command => "add-apt-repository ppa:masterminds/glide && \
                apt-get update && \
                apt-get install -y glide"
}

include envvars
