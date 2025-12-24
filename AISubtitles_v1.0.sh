#!/bin/sh

# Script for installing/updating AISubtitles plugin

# Plugin information
plugin=AISubtitles
version=1.0
url="https://raw.githubusercontent.com/Ham-ahmed/24/refs/heads/main/AISubtitles_v1.0.tar.gz"
package="/var/volatile/tmp/$plugin-$version.tar.gz"

# Check if plugin already exists
if [ -d "/usr/lib/enigma2/python/Plugins/Extensions/$plugin" ]; then
    echo "> Removing old package please wait..."
    sleep 3
    rm -rf "/usr/lib/enigma2/python/Plugins/Extensions/$plugin" >/dev/null 2>&1
    
    echo "*******************************************"
    echo "*             Removal Finished            *"
    echo "*******************************************"
    sleep 3
fi

echo "> Downloading $plugin $version please wait..."
sleep 3

# Clean up unnecessary files
rm -rf /var/volatile/tmp/*.ipk >/dev/null 2>&1
rm -rf /var/volatile/tmp/*.tar.gz >/dev/null 2>&1

# Download the plugin
wget -q --no-check-certificate -O "$package" "$url"
download_status=$?

if [ $download_status -eq 0 ]; then
    echo "> Extraction in progress..."
    
    # Extract the plugin
    tar -xzf "$package" -C / >/dev/null 2>&1
    extract_status=$?
    
    # Clean up downloaded package
    rm -f "$package" >/dev/null 2>&1
    
    # Clean control files if they exist
    rm -f /CONTROL /control /postinst /preinst /prerm /postrm >/dev/null 2>&1
    rm -rf /CONTROL /control >/dev/null 2>&1
    
    echo ""
    if [ $extract_status -eq 0 ]; then
        echo "> $plugin $version installed successfully"
        sleep 3
    else
        echo "> $plugin installation failed (extraction error)"
        sleep 3
        exit 1
    fi
else
    echo "> Download failed! Please check your internet connection"
    sleep 3
    exit 1
fi

wait
sleep 2
echo ""
echo ""
echo "#########################################################"
echo "#                INSTALLED SUCCESSFULLY                 #"
echo "#               ON - MagicPanelPro v6.6                 #"
echo "#             Enigma2 restart is required               #"
echo "#        .::UPLOADED BY  >>>>   HAMDY_AHMED::.          #"
echo "#     https://www.facebook.com/share/g/18qCRuHz26/      #"
echo "#########################################################"
echo "#           Your Device will RESTART Now                #"
echo "#########################################################"
wait
sleep 2

# Restart enigma2
killall -9 enigma2
exit 0