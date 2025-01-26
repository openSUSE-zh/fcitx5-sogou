#
# spec file for package fcitx5-sogou
#
# Copyright (c) 2025 SUSE LLC
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via https://bugs.opensuse.org/
#


Name:           fcitx5-sogou
Version:        10.0.9.0.6
Release:        0
Summary:        Sogou Pinyin for Linux
License:        MIT
URL:            https://shufufa.sogou.com/linux
Source:         %{name}-%{version}.tar.gz
Source1:        file.txt

%description
Sogou Pinyin for Linux based on Fcitx5 and the new CPIS engine

%prep
%autosetup

%build

%install
mkdir -p %{buildroot}
mv etc %{buildroot}
mv usr %{buildroot}
mv var %{buildroot}

rm -rf %{buildroot}%{_datadir}/doc

mkdir -p %{buildroot}%{_libdir}/fcitx5
ln -sf %{_prefix}/lib/x86_64-linux-gnu/cpis-module-im-fcitx5.so \
  %{buildroot}%{_libdir}/fcitx5/libcpis-module-im-sogou-ime-ng-fcitx5-kylin-desktop.so
%find_lang fcitx5-sogou-ime-ng-fcitx5-kylin-desktop
cat %{_sourcedir}/file.txt >> fcitx5-sogou-ime-ng-fcitx5-kylin-desktop.lang

%files -f fcitx5-sogou-ime-ng-fcitx5-kylin-desktop.lang
%dir %{_libdir}/fcitx5
%{_libdir}/fcitx5/libcpis-module-im-sogou-ime-ng-fcitx5-kylin-desktop.so

%changelog

