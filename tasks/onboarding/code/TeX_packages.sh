#!/bin/bash

#slides packages
sudo tlmgr install beamertheme-metropolis appendixnumberbeamer fmtcount datetime epstopdf
#paper packages
sudo tlmgr install appendix placeins physics etoc epstopdf footmisc chktex
#logbook packages
sudo tlmgr install bbm bbm-macros csvsimple

echo 'Shell script to install TeX packages ran. Here is the list of installed TeX packages:' > ../output/TeX_packages.txt
tlmgr info --list --only-installed >> ../output/TeX_packages.txt
