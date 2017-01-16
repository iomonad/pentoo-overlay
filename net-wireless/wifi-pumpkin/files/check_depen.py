#coding: utf-8
from core.utility.collection import SettingsINI
from os import path,popen,remove,system,chdir
import sys
from shutil import copy
YELLOW = '\033[33m'
RED = '\033[91m'
ENDC = '\033[0m'

def notinstall(app):
    print '[%s✘%s] %s is not %sinstalled%s.'%(RED,ENDC,app,YELLOW,ENDC)

def check_dep_pumpkin():
    # check hostapd
    hostapd = popen('which hostapd').read().split('\n')
    if not path.isfile(hostapd[0]): notinstall('hostapd')
    # checck source.tar.gz tamplate module
    if '/usr/sbin/wifi-pumpkin' in sys.argv[0]:
        chdir('/usr/share/wifi-pumpkin')

    # check if hostapd is found and save path
    settings = SettingsINI('core/config/app/config.ini')
    hostapd_path = settings.get_setting('accesspoint','hostapd_path')
    if not path.isfile(hostapd_path) and len(hostapd[0]) > 2:
        return settings.set_setting('accesspoint','hostapd_path',hostapd[0])
    elif not path.isfile(hostapd[0]):
        return settings.set_setting('accesspoint','hostapd_path','0')