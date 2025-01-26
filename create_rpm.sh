#!/bin/bash

URL="http://archive.build.openkylin.top"
CPIS_VERSION="10.0.9.0.6"
DATA_VERSION="10.0.1-48.1"

wget ${URL}/openkylin/pool/pty/c/cpis/cpis-base_${CPIS_VERSION}-202311280935_amd64.deb
wget ${URL}/openkylin/pool/pty/s/sogou-ime-ng-data/sogou-ime-ng-cpis-dict-keyboard-chs-pcpy_${DATA_VERSION}_all.deb
wget ${URL}/openkylin/pool/pty/s/sogou-ime-ng-data/sogou-ime-ng-cpis-dict-keyboard-chs-pcwb_${DATA_VERSION}_all.deb
wget ${URL}/openkylin/pool/pty/s/sogou-ime-ng-data/sogou-ime-ng-cpis-dict-keyboard-multilingual-pcen_${DATA_VERSION}_all.deb
wget ${URL}/openkylin/pool/pty/s/sogou-ime-ng-data/sogou-ime-ng-cpis-user-default-profile_${DATA_VERSION}_all.deb
wget ${URL}/openkylin/pool/pty/s/sogou-ime-ng/sogou-ime-ng-fcitx5-kylin-desktop_${CPIS_VERSION}-20231128000607_amd64.deb
wget ${URL}/openkylin/pool/pty/s/sogou-ime-ng/sogou-ime-ng_${CPIS_VERSION}-20231128000607_amd64.deb

OUT="fcitx5-sogou-${CPIS_VERSION}"
mkdir -p $OUT

for deb in $(ls *.deb); do
  dir=${deb/.deb/}
  mkdir -p $dir
  bsdtar -C $dir -xf $deb
  bsdtar -C $OUT -xf $dir/data.tar.*
done

chrpath -d $OUT/usr/lib/x86_64-linux-gnu/cpis-engine-plugin/sogou/libsogounlp.so
chrpath -d $OUT/usr/lib/x86_64-linux-gnu/cpis-engine-plugin/sogou/libhandwriting_fc.so

tar -cvf ${OUT}.tar.gz ${OUT}
rm -rf ${OUT}

ls -l

mkdir -p ~/rpmbuild/SOURCES
cp ${OUT}.tar.gz ~/rpmbuild/SOURCES
cp file.txt ~/rpmbuild/SOURCES

rpmbuild -ba fcitx5-sogou.spec
mkdir -p release
cp ~/rpmbuild/RPMS/x86_64/*.rpm release
cp ~/rpmbuild/SRPMS/*.rpm release
ls -l release
