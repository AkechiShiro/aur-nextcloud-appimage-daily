#!/usr/bin/bash
set -x
cd nextcloud-client-appimage-daily || echo "Failed to CD" && exit 1
ls -lah
url="https://download.nextcloud.com/desktop/daily/linux/"
pkgnew=$(curl -s $url | tail -n 5 | sed -nE 's/.*href=\"(linux-[^\-]*)">.*/\1/p')
pkgver_date=$(curl -s $url | tail -n 5 | sed -nE 's/.*href=\"linux-([^\-]*).AppImage">.*/\1/p')
echo "pkg:$pkgnew, date:$pkgver_date"
[[ -f "$pkgnew" ]] || wget "$url/$pkgnew"
chmod a+x "./$pkgnew"
"./$pkgnew" --appimage-extract
# TODO: Find version from AppRun
real_pkgver=$("./squashfs-root/AppRun" -v | sed -nE "s/^Nextcloud version ([0-9]*\.[0-9]*\.[0-9]*) (.*)$/\1/p")
sed -Ei "1,\$s|^(pkgver=).*|\1$real_pkgver.$pkgver_date|" PKGBUILD
updpkgsums ./PKGBUILD
makepkg --printsrcinfo > .SRCINFO
makepkg PKGBUILD --clean --cleanbuild --force -si 
# TODO: Figure out a way to push to the AUR the upgrade safely without putting any creds plain text
# DevSecOps, gotta to improve those skills cause why not

#&& git add -A . && git commit -m "Update to latest version" && git push

