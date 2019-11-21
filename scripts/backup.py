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

def compressExec(cmd):
    print(cmd)
    c = str.encode(cmd)
    sh = Popen([str.encode('bash')], stdin=PIPE, stdout=PIPE, stderr=PIPE)
    out, err = sh.communicate(input = c)
    sh.kill()
    return err

def makeBackup(fp):
    options = makeOptions()
    cmdStr = makeArgs(compress[0] + " " + options + " " + fp)
    err = compressExec(cmdStr)
    if err != b"":
        print(err.decode("utf-8"))
    else:
        print("Successfully saved \"" + fp + "\" !")

def main(info):
    fpZip = makeBackupFp()
    makeBackup(fpZip)
    if info == True:
        os.remove(src[3])
        print("Removed: " + src[3])

def handleCmdLine():
    info = False
    if "help" in argv or "-h" in argv:
        help()
    if len(argv) >= 2 and "--" not in argv[1]:
        src.append(argv[1])
        info = True
    for arg in argv:
        if "--compress=" in arg:
            c = arg[arg.find('=')+1:]
            if c == "tar":
                compress[0] = "tar"
                compress[1] = ".tar.gz"
    return info

if __name__ == '__main__':
    info = handleCmdLine()
    main(info)
