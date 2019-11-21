#!/usr/bin/env python3

from subprocess import Popen, PIPE
from datetime import datetime
from sys import argv
import os

buDir = "./backups"
src = ["./src", "./lib", "Makefile"]
compress = ["zip", ".zip"]

def help():
    print("DESCRIPTION:\n\t"+argv[0]+" [info_file] [options]\n\t"
          "Create an archive backing up src/ lib/ & Makefile\n\n"
          "PARAMETERS:\n\tinfo_file\tFile describing the content"
          " of the backup.\n\t--compress=[x]\t[tar | zip(def)] compression bin.")
    exit(0)

def getGitBranch():
    file = open(".git/HEAD", "r")
    content = file.read()
    file.close()

    head = content[content.rfind('/')+1:len(content)-1]
    return head

def makeBackupFp():
    branch = getGitBranch()
    fpZip = buDir + os.sep + branch

    if not os.path.exists(fpZip):
        os.mkdir(fpZip)

    fpZip += os.sep + datetime.now().strftime("%Y-%m-%d_%H-%M-%S") + compress[1]
    return fpZip

def makeOptions():
    options = ""
    if compress[0] == "zip":
        options += "-r"
    if compress[0] == "tar":
        options += "-czvf"
    return options

def makeArgs(beg):
    for arg in src:
        beg += " "+arg
    return beg

def makeBackup(fp):
    options = makeOptions()
    cmdStr = makeArgs(compress[0] + " " + options + " " + fp)
    print("Executing:\t"+cmdStr)
    cmd = str.encode(cmdStr)
    sh = Popen([str.encode('bash')], stdin=PIPE, stdout=PIPE, stderr=PIPE)
    out, err = sh.communicate(input = cmd)
    sh.kill()
    if err != b'':
        print(err.decode("utf-8"))

def main():
    fpZip = makeBackupFp()
    makeBackup(fpZip)

def handleCmdLine():
    if "help" in argv or "-h" in argv:
        help()
    if len(argv) >= 2 and "--" not in argv[1]:
        src.append(argv[1])
    for arg in argv:
        if "--compress=" in arg:
            c = arg[arg.find('=')+1:]
            if c == "tar":
                compress[0] = "tar"
                compress[1] = ".tar.gz"


if __name__ == '__main__':
    handleCmdLine()
    main()
