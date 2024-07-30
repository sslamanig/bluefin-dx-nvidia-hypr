#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Add COPR repositories (credits go to https://github.com/cjuniorfox/hyprland-atomic/)
for i in solopasha/hyprland; do
    MAINTAINER="${i%%/*}"
    REPOSITORY="${i##*/}"
    curl --output-dir "/etc/yum.repos.d/" --remote-name \
    "https://copr.fedorainfracloud.org/coprs/${MAINTAINER}/${REPOSITORY}/repo/fedora-${RELEASE}/${MAINTAINER}-${REPOSITORY}-fedora-${RELEASE}.repo"
done

# this installs a package from fedora repos
rpm-ostree install hyprland \
    xdg-desktop-portal-hyprland \
    hyprpaper \
    hypridle \
    hyprlock \
    hyprnome \
    hyprpicker \
    hyprshot \
    waybar-git \
    dunst \
    wlogout \
    alacritty \
    wofi \
    network-manager-applet \
    bluez \
    blueman \
    cliphist \
    brightnessctl \
    wpctl \
    playerctl \
    fira-code-fonts

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
