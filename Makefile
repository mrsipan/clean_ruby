puppet: puppet-4.1.0.tar.gz facter-2.4.4.tar.gz hiera-2.0.0.tar.gz
	#rpmbuild --rebuild *.src.rpm
	tar -xvzf facter-2.4.4.tar.gz
	sudo /opt/clean_ruby/2.2.0/bin/ruby facter-2.4.4/install.rb
	tar -xvzf hiera-2.0.0.tar.gz
	sudo /opt/clean_ruby/2.2.0/bin/ruby hiera-2.0.0/install.rb --configdir=/opt/puppet/etc
	tar -xvzf puppet-4.1.0.tar.gz
	sudo /opt/clean_ruby/2.2.0/bin/ruby puppet-4.1.0/install.rb --configdir=/opt/puppet/etc --codedir=/opt/puppet/code --vardir=/opt/puppet/var

ruby-2.2.0.tar.gz:
	curl -o ruby-2.2.0.tar.gz http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.0.tar.gz

clean_ruby_src_rpm: ruby-2.2.0.tar.gz
	rpmbuild -bs --nodeps --define "_sourcedir ." --define "_srcrpmdir ." specs/clean_ruby_22.spec

puppet-4.1.0.tar.gz:
	curl -o puppet-4.1.0.tar.gz https://downloads.puppetlabs.com/puppet/puppet-4.1.0.tar.gz

facter-2.4.4.tar.gz:
	curl -o facter-2.4.4.tar.gz https://downloads.puppetlabs.com/facter/facter-2.4.4.tar.gz

hiera-2.0.0.tar.gz:
	curl -o hiera-2.0.0.tar.gz https://downloads.puppetlabs.com/hiera/hiera-2.0.0.tar.gz

clean:
	$(RM) *.tar.gz *.src.rpm
