#!/usr/bin/bash
set -x
url="https://download.nextcloud.com/desktop/daily/linux/"
pkgnew=$(curl -s $url | tail -n 5 | sed -nE 's/.*href=\"(linux-[^\-]*)">.*/\1/p')
pkgver_date=$(curl -s $url | tail -n 5 | sed -nE 's/.*href=\"linux-([^\-]*).AppImage">.*/\1/p')
echo "pkg:$pkgnew, date:$pkgver_date"
[[ -f "$pkgnew" ]] || wget "$url/$pkgnew"
chmod a+x "./$pkgnew"
"./$pkgnew" --appimage-extract 2&>/dev/null
# TODO: Find version from AppRun
# Fix for : https://github.com/NVlabs/instant-ngp/discussions/300
export QT_QPA_PLATFORM=offscreen
real_pkgver=$(strings ./squashfs-root/AppRun | sed -nE "s/^([0-9]\.[0-9]\.[0-9][0-9]\.[0-9]*)/\1/p")
sed -Ei "1,\$s|^(pkgver=).*|\1$pkgver_date|" PKGBUILD
updpkgsums ./PKGBUILD
makepkg --printsrcinfo > .SRCINFO
makepkg PKGBUILD --clean --cleanbuild --force
# TODO: Figure out a way to push to the AUR the upgrade safely without putting any creds plain text
# DevSecOps, gotta to improve those skills cause why not

#&& git add -A . && git commit -m "Update to latest version" && git push

