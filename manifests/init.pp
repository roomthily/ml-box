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
      [ "python", "python-setuptools", "python-dev", "python-pip", "python-matplotlib"]:
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

class scikit {
  package { 
    [ "python-scipy", "libatlas-dev", "libatlas3gf-base"]:
      ensure => ["installed"],
      require => Exec['apt-update']    
  } ->
  exec {
    "libblas":
    command => "/usr/bin/sudo update-alternatives --set libblas.so.3 /usr/lib/atlas-base/atlas/libblas.so.3"
  } ->
  exec {
    "liblapack":
    command => "/usr/bin/sudo update-alternatives --set liblapack.so.3 /usr/lib/atlas-base/atlas/liblapack.so.3"
  } ->
  exec {
    "scikit":
    command => "/usr/bin/sudo pip install scikit-learn",
    require => Package["python", "python-pip"]
  }

}



include core
include python
include nltk
include scikit

#sudo apt-get update
#sudo apt-get install build-essential
#sudo apt-get install python-setuptools python-pip python-dev
#sudo pip install ipython
#sudo pip install -U numpy
#sudo pip install -U nltk
#FOR THE DATA
#sudo python -m nltk.downloader all -d /usr/share/nlkt_data.all
#for scikit-learn which may be unnecessary but isn't going to hurt
#sudo apt-get install python-scipy libatlas-dev libatlas3gf-base
#for ubuntu 13 >
#sudo update-alternatives --set libblas.so.3 /usr/lib/atlas-base/atlas/libblas.so.3
#sudo update-alternatives --set liblapack.so.3 /usr/lib/atlas-base/atlas/liblapack.so.3
#install it
#sudo pip install scikit-learn
#sudo apt-get install python-matplotlib