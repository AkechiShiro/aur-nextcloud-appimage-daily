# Automatic upgrade of PKGBUILD version for nextcloud-appimage-daily for the AUR

This uses Ubuntu with an Archlinux Docker in GitHub Actions to automatically build the PKGBUILD and push it upstream to the AUR automatically.

- The script `update.sh` gets the latest version from Nextcloud endpoint where AppImage are being served and pull the latest version. 

