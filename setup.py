import sys
import os
import shutil
import pathlib


def copy(src, des):
    dest = os.path.join('/usr/local/bin/omm')
    if os.path.exists(dest):
        os.remove(dest)
    shutil.copy(src, dest)
    print(f"Copied executable to {dest}.")


def move_exe_to_bin(file_name):
    os_name = pathlib.os.name
    file_loc = os.path.join(os.curdir, file_name)
    if os_name == "posix":
        dest = os.path.join('/usr/local/bin/omm')
        copy(file_loc, dest)
    elif os_name == "nt":
        dest = os.path.join('C:\\Windows\\System32\\omm')
        copy(file_loc, dest)


file_name = sys.argv[1]
move_exe_to_bin(file_name)
