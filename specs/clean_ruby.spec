%define ruby_version 2.4.2

Name: clean_ruby
Version: %{ruby_version}
Release: 1
License: Ruby License/GPL
URL: http://www.ruby-lang.org
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root
BuildRequires: automake
BuildRequires: zlib-devel
BuildRequires: libyaml-devel
BuildRequires: ncurses-devel
BuildRequires: gdbm-devel
# for fedora 26
BuildRequires: compat-openssl10-devel
# BuildRequires: openssl-devel
BuildRequires: libffi-devel
BuildRequires: db4-devel
BuildRequires: tcl-devel
BuildRequires: unzip
Requires: libyaml
Source: ruby-%{version}.tar.gz
Summary: An interpreter of object-oriented scripting language
Group: Development/Language

%description
Ruby is an interpreted scripting language.

%prep
%setup -n ruby-%{version}

%build
export CFLAGs="$RPM_OPT_FLAGS -Wall -fno-strict-aliasing"
./configure --prefix=/opt/%{name}/%{version} \
  --enable-shared --enable-rpath --with-opt-dir=/opt/%{name}/%{version}
make %{?_smp_mflags}

%install
make install DESTDIR=$RPM_BUILD_ROOT

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-, root, root)
/opt/%{name}/%{version}

# %changelog
# * Thu Sep 28 2017
# - First Version
