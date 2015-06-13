all: clean_ruby_22-2.2.0-1.src.rpm

ruby-2.2.0.tar.gz:
	curl -o ruby-2.2.0.tar.gz http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.0.tar.gz

clean_ruby_22-2.2.0-1.src.rpm: ruby-2.2.0.tar.gz
	rpmbuild -bs --nodeps --define "_sourcedir ." --define "_srcrpmdir ." specs/clean_ruby_22.spec

clean:
	$(RM) *.tar.gz *.src.rpm



