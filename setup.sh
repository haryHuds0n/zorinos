#!/bin/bash

######################################### Zulip ##################################################
USERNAME=$(whoami)

sudo apt clean

# Add zulip asc.
sudo curl -fL -o /etc/apt/trusted.gpg.d/zulip-desktop.asc \
    https://download.zulip.com/desktop/apt/zulip-desktop.asc

echo "deb https://download.zulip.com/desktop/apt stable main" | \
    sudo tee /etc/apt/sources.list.d/zulip-desktop.list

# Download and install zulip
sudo apt update
sudo apt install zulip libnss3-tools

######################################### Vscode ##################################################

# Download .deb package.
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

# Install package
sudo apt update
sudo apt install code

######################################### Google Chrome #########################################

# Download google chrome .dev package.
curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o google-chrome.deb
sudo dpkg -i google-chrome.deb

######################################### Postman #########################################

# Download postman archive.
curl https://dl.pstmn.io/download/latest/linux_64 -o postman.tar.gz
sudo tar xf postman.tar.gz -C /opt

echo "
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/Postman/app/Postman %U
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
" | sudo tee /usr/share/applications/postman.desktop

######################################### Telegram #########################################
# Download telegram
curl -L https://telegram.org/dl/desktop/linux -o tsetup.tar.xz
sudo tar xf tsetup.tar.xz -C /opt

echo " 
[Desktop Entry]
Encoding=UTF-8
Name=Telegram
Exec=/opt/Telegram/Telegram %U
Icon=telegram
Terminal=false
Type=Application
Categories=Development;
" | sudo tee /usr/share/applications/telegram.desktop

######################################### Firefox #########################################
sudo install -d -m 0755 /etc/apt/keyrings

wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null

echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla

sudo apt-get update && sudo apt-get install firefox -y
# Start firefox in headless mode and run in background in order to create default porfile
nohup firefox --headless &

echo " 
[Desktop Entry]
Encoding=UTF-8
Name=Firefox
Exec=/usr/bin/firefox %U
Icon=/var/lib/flatpak/exports/share/icons/hicolor/128x128/apps/org.mozilla.firefox.png
Terminal=false
Type=Application
Categories=Development;
" | sudo tee /usr/share/applications/firefox.desktop

######################################### Teams #########################################
sudo mkdir -p /etc/apt/keyrings

sudo wget -qO /etc/apt/keyrings/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc

echo "deb [signed-by=/etc/apt/keyrings/teams-for-linux.asc arch=$(dpkg --print-architecture)] https://repo.teamsforlinux.de/debian/ stable main" | sudo tee /etc/apt/sources.list.d/teams-for-linux-packages.list

sudo apt update

sudo apt install teams-for-linux


TeamIcon=$(find / -name com.github.IsmaelMartinez.teams_for_linux.png 2>/dev/null | grep 128)

echo " 
[Desktop Entry]
Encoding=UTF-8
Name=Teams
Exec=/usr/bin/teams-for-linux %U
Icon=$TeamIcon
Terminal=false
Type=Application
Categories=Development;
" | sudo tee /usr/share/applications/teams.desktop

######################################### Create Desktop Shortcut #########################################

cp /usr/share/applications/code.desktop /home/"$USERNAME"/Desktop
cp /usr/share/applications/google-chrome.desktop /home/"$USERNAME"/Desktop
cp /usr/share/applications/telegram.desktop /home/"$USERNAME"/Desktop
cp /usr/share/applications/postman.desktop /home/"$USERNAME"/Desktop
cp /usr/share/applications/zulip.desktop /home/"$USERNAME"/Desktop
cp /usr/share/applications/firefox.desktop /home/"$USERNAME"/Desktop
cp /usr/share/applications/teams.desktop /home/"$USERNAME"/Desktop

# Mark Desktop File Executable
chmod +x /home/"$USERNAME"/Desktop/*.desktop
# Mark Application Trusted
gio set /home/"$USERNAME"/Desktop/code.desktop metadata::trusted true
gio set /home/"$USERNAME"/Desktop/google-chrome.desktop metadata::trusted true
gio set /home/"$USERNAME"/Desktop/telegram.desktop metadata::trusted true
gio set /home/"$USERNAME"/Desktop/postman.desktop metadata::trusted true
gio set /home/"$USERNAME"/Desktop/zulip.desktop metadata::trusted true
gio set /home/"$USERNAME"/Desktop/firefox.desktop metadata::trusted true
gio set /home/"$USERNAME"/Desktop/teams.desktop metadata::trusted true