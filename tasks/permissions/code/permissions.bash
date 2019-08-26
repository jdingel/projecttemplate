#!/bin/bash
projectdirectory=/project/jdingel
projectgroup=pi-jdingel

#Change directory ownership
echo "The following directories do not have group ${projectgroup}:"
find ${projectdirectory} -type d -not -group ${projectgroup}
echo "Changing group ownership to ${projectgroup}"
find ${projectdirectory} -type d -not -group ${projectgroup} -exec chgrp ${projectgroup} {} \;

#Change file ownership
echo "The following files do not have group ${projectgroup}:"
find ${projectdirectory} -type f -not -group ${projectgroup}
echo "Changing group ownership to ${projectgroup}"
find ${projectdirectory} -type f -not -group ${projectgroup} -exec chgrp ${projectgroup} {} \;

#Change directories' write permissions
echo "Group members do not have write permissions on the following directories"
find ${projectdirectory} -type d -group ${projectgroup} -not -perm -g=w
echo "Give group members write permissions"
find ${projectdirectory} -type d -group ${projectgroup} -not -perm -g=w -exec chmod 770 {} \;

#Check sticky bits
echo "The sticky bit isn't set on the following directories:"
find ${projectdirectory} -type d -group ${projectgroup} -not -perm -2000
echo "Set the stick bits on those directories:"
find ${projectdirectory} -type d -group ${projectgroup} -not -perm -2000 -exec chmod g+s {} \;
