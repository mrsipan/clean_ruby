puppet: build_clean_ruby puppet-4.1.0.tar.gz facter-2.4.4.tar.gz hiera-2.0.0.tar.gz
	tar -xvzf facter-2.4.4.tar.gz
	/opt/clean_ruby/2.4.2/bin/ruby facter-2.4.4/install.rb
	tar -xvzf hiera-2.0.0.tar.gz
	/opt/clean_ruby/2.4.2/bin/ruby hiera-2.0.0/install.rb --configdir=/opt/puppet/etc
	tar -xvzf puppet-4.1.0.tar.gz
	/opt/clean_ruby/2.4.2/bin/ruby puppet-4.1.0/install.rb --configdir=/opt/puppet/etc --codedir=/opt/puppet/code --vardir=/opt/puppet/var

ruby-2.4.2.tar.gz:
	curl -o ruby-2.4.2.tar.gz http://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.2.tar.gz

build_clean_ruby: ruby-2.4.2.tar.gz
	dnf group install -y "Development Tools"
	dnf group install -y "Development Libraries"
	dnf remove -y openssl-devel
	dnf group install -y "RPM Development Tools"
	dnf -y install rpm-build dnf-utils
	yum-builddep -y specs/clean_ruby.spec
	rpmbuild -bs --nodeps --define "_sourcedir ." --define "_srcrpmdir ." specs/clean_ruby.spec
	rpmbuild --rebuild *.src.rpm
	dnf install -y ${HOME}/rpmbuild/RPMS/x86_64/clean_ruby-2.4.2-1.x86_64.rpm

puppet-4.1.0.tar.gz:
	curl -o puppet-4.1.0.tar.gz https://downloads.puppetlabs.com/puppet/puppet-4.1.0.tar.gz

facter-2.4.4.tar.gz:
	curl -o facter-2.4.4.tar.gz https://downloads.puppetlabs.com/facter/facter-2.4.4.tar.gz

hiera-2.0.0.tar.gz:
	curl -o hiera-2.0.0.tar.gz https://downloads.puppetlabs.com/hiera/hiera-2.0.0.tar.gz

clean:
	$(RM) *.tar.gz *.src.rpm
