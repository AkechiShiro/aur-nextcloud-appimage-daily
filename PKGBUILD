# Maintainer: Lahfa Samy <'akechishiro-aur' at 'lahfa[dot]xyz'>
# Contributor: Felix Golatofski <contact@xdfr.de>
# Contributor: Sebastian Wieland <wieland.s[at]online[dot]de>
_pkgname=nextcloud
pkgname=${_pkgname}-client-appimage-daily
pkgver=20250102
_appimgname=linux-${pkgver##*.}
pkgrel=1
epoch=1
pkgdesc="Nextcloud desktop client (official daily AppImage build)"
arch=('x86_64' 'i686')
url="https://download.nextcloud.com/desktop/daily/linux"
license=('GPL2')
provides=('nextcloud-client')
conflicts=('nextcloud-client' 'nextcloud-client-git' 'owncloud-client')
depends=('zlib')
optdepends=('hicolor-icon-theme: needed for hicolor theme hierarchy')
makedepends=('p7zip' 'curl')
noextract=("$_appimgname.AppImage")
options=('!strip')
source=(${_pkgname}-${pkgver}.AppImage::${url}/${_appimgname}.AppImage)
sha256sums=('2d64d9c52c823f3a9ab51b8109d93633d0ad92d61ce2dc16a727745cd7c52fa8')

prepare() {
    cd "${srcdir}"

    # Extract relevant files from AppImage
    7z x -y ${_pkgname}-${pkgver}.AppImage usr/share/icons > /dev/null
    7z x -y ${_pkgname}-${pkgver}.AppImage usr/share/applications/com.${_pkgname}.desktopclient.${_pkgname}.desktop > /dev/null
    mv usr/share/applications/com.${_pkgname}.desktopclient.${_pkgname}.desktop com.${_pkgname}.desktopclient.${_pkgname}.desktop
}

package() {
  cd "${srcdir}"

  # Copy Icons
  install -dm644 "${pkgdir}/usr/share/icons"
  cp -dpr --no-preserve=ownership "usr/share/icons" "${pkgdir}/usr/share"
  find "${pkgdir}/usr/share/icons" -type d -exec chmod 755 {} \;

  # Install to /opt/appimage/
  install -Dm644 "com.${_pkgname}.desktopclient.${_pkgname}.desktop" "${pkgdir}/usr/share/applications/${_pkgname}.desktop"
  install -Dm755 "${_pkgname}-${pkgver}.AppImage" "${pkgdir}/opt/appimages/${_pkgname}.AppImage"

  # Create Link in /usr/bin/
  install -d "${pkgdir}/usr/bin"
  ln -s "/opt/appimages/${_pkgname}.AppImage" "${pkgdir}/usr/bin/${_pkgname}"
}
