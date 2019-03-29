import glob
import subprocess
import shlex
import os
import sys
from shutil import copyfile
RED = '\033[0;31m'
NC = '\033[0m' # No Color

executable = "bin/jpsvis.app/Contents/MacOS/jpsvis"
cmd = "otool -L %s"%executable

f = open("blah.txt", "w")
res = subprocess.call(shlex.split(cmd), stdout=f)
f.close()
f = open("blah.txt", "r")
lines = f.readlines()
for line in lines:
    if line.find("Qt") > 0 and line.find("vtk") < 0:
        old_qt_dep = line.split()[0]
        filename = old_qt_dep.split("/")[-1]
        new_qt_dep = "bin/jpsvis.app/Contents/libs/%s"%filename
        if not os.path.exists(new_qt_dep):
            copyfile(old_qt_dep, new_qt_dep)


        change = "install_name_tool -change %s %s %s"%(old_qt_dep, "@executable_path/../libs/%s"%filename, executable)
        print("<< old: ", old_qt_dep)
        print(">> new: ", "@executable_path/../libs/%s"%filename)
        res = subprocess.call(shlex.split(change))

        # todo: The copied qt libs should not reference system libs.

        # Library not loaded: /usr/local/Cellar/qt/5.12.2/lib/QtCore.framework/Versions/5/QtCore
        # Referenced from: /Applications/jpsvis.app/Contents/libs/QtNetwork
