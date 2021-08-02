#!/bin/bash

# search "Cmnd_Alias DRIVERS" after insert line "..."
sed -i '/Cmnd_Alias DRIVERS/'a\ "\ \n## AI \nCmnd_Alias DC=/usr/bin/yum" /etc/sudoers
