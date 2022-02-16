#!/usr/bin/env python3

import os
import sys
import subprocess
import shutil
import datetime

######## GLOBALS #########
MAINPREFIX = "z"
PREFIX = "a3csserver_"
IGNOREADDONS = []
##########################

vendoraddons = []

def mod_time(path):
    if not os.path.isdir(path):
        return os.path.getmtime(path)
    maxi = os.path.getmtime(path)
    for p in os.listdir(path):
        maxi = max(mod_time(os.path.join(path, p)), maxi)
    return maxi

def check_for_changes(addonspath, module):
    if not os.path.exists(os.path.join(addonspath, "{}{}.pbo".format(PREFIX,module))):
        return True
    return mod_time(os.path.join(addonspath, module)) > mod_time(os.path.join(addonspath, "{}{}.pbo".format(PREFIX,module)))

def check_for_obsolete_pbos(addonspath, file):
    if file in vendoraddons:
        return False
    module = file[len(PREFIX):-4]
    if not os.path.exists(os.path.join(addonspath, module)):
        return True
    return False

def copy_vendor_file(source, target):
    file = os.path.basename(source)
    filepath = os.path.join(target, file)

    if os.path.exists(filepath):
        if (mod_time(source) <= mod_time(filepath)):
            return False
        os.remove(filepath)

    shutil.copy2(source, target)

    return True

def main():
    print("""
  ####################
  # A3CS Server Debug Build #
  ####################
""")

    scriptpath = os.path.realpath(__file__)
    projectpath = os.path.dirname(os.path.dirname(scriptpath))
    hemttExe = os.path.join(projectpath, "hemtt.exe")
    addonspath = os.path.join(projectpath, "addons")

    ### Build A3CS Server

    os.chdir(projectpath)

    print("  Building A3CS Server")
    print("")
    hemttRet = subprocess.call([hemttExe, "pack"], stderr=subprocess.STDOUT)
    print("Result: {}".format(hemttRet));

    ### Log finish

    print("")
    print("\n# A3CS Server debug build done\n")
    print("  {}".format(datetime.datetime.now()))
    print("")

if __name__ == "__main__":
    sys.exit(main())
