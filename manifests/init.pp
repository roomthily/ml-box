class core {
  
    exec { "apt-update":
      command => "/usr/bin/sudo apt-get -y update"
    }
  
    package { 
      [ "git-core", "build-essential"]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }
}

class python {

    package { 
      [ "python", "python-setuptools", "python-dev", "python-pip"]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }

    exec {
      "ipython":
      command => "/usr/bin/sudo pip install ipython",
      require => Package["python-dev", "python-pip"]
    }

    exec {
      "requests":
      command => "/usr/bin/sudo pip install requests",
      require => Package["python", "python-pip"],
    }
}

class nltk {
	exec {
		"numpy":
		command => "/usr/bin/sudo pip install numpy",
		require => Package["python", "python-pip"]
	} ->
	exec {
		"nltk":
		command => "/usr/bin/sudo pip install nltk",
		require => Package["python", "python-pip"]
	}
}

include core
include python
include nltk

#sudo apt-get update
#sudo apt-get install build-essential
#sudo apt-get install python-setuptools python-pip python-dev
#sudo pip install ipython
#sudo pip install -U numpy
#sudo pip install -U nltk
