#!/bin/bash
### Install packages ###
sudo apt update && sudo apt upgrade -y && sudo apt install -y vlc gparted jupyter neovim
sudo snap refresh


### Customize settings ###
## Download Remakers wallpapers and set the dark one
WALLPAPER_PATH="/home/$USER/Pictures/remakers_wallpaper_4k_dark.png"
wget https://github.com/ReMakersLab/XubuntuCustomizations/blob/master/images/wallpapers/remakers_wallpaper_4k_dark.png?raw=true -O $WALLPAPER_PATH
wget https://github.com/ReMakersLab/XubuntuCustomizations/blob/master/images/wallpapers/remakers_wallpaper_4k_light.png?raw=true -O "/home/$USER/Pictures/remakers_wallpaper_4k_light.png"

pcmanfm-qt --set-wallpaper "$WALLPAPER_PATH" --wallpaper-mode fit

## Customize Firefox
# Open and close Firefox to create profile
firefox &
sleep 10
pkill firefox
PROFILE_DIR=$(find ~/snap/firefox/common/.mozilla/firefox/*.default* -maxdepth 0 2>/dev/null | head -n 1)
# Set Remakers website as startup homepage
echo 'user_pref("browser.startup.homepage", "https://www.remakers.it");' >> "$PROFILE_DIR/user.js"
# Set DuckDuckGo as default search engine
echo 'user_pref("browser.search.defaultenginename", "DuckDuckGo");' >> "$PROFILE_DIR/user.js"

# Install uBlock Origin extension
FIREFOX_POLICIES_DIR_ETC=/etc/firefox/policies
echo '{
	"policies": {
		"Extensions": {
			"Install": [
				"https://addons.mozilla.org/firefox/downloads/file/4328681/ublock_origin-1.59.0.xpi"
			],
			"Locked": [
				"ublock_origin@raymondhill.net"
			]
		}
	}
}' > "policies.json.tmp"
sudo mv policies.json.tmp "$FIREFOX_POLICIES_DIR_ETC/policies.json"
