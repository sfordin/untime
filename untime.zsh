#!/bin/zsh
#  =====================================================================
#                        *** UNTIME ***
#  This script unmounts temporary Time Machine mounts that might be
#  left behind by interrupted or incomplete Time Machine runs.
#
#  The behaviors of this script are as follows:
#
#    - The Time Machine mounts are referenced relative to the default
#      MacOS user mount directory; for example, /Volumes/<mount_dir>.
#
#    - The Time Machine mounts are *not* referenced by their device
#      directory or network share names; for example, /dev/disk<nn>
#      or //<server_name>/<share_name>.
#
#    - The only affected mounts are those that are named using the
#      default temporary pattern /Volumes/.timemachine<name>.backup.
#
#    - The script does not touch anything in /Volumes/.timemachine or
#      in /Volumes/com.apple.TimeMachine.localsnapshots.
#
#    - You must run this script as root or with sudo.
#
#  Copyright (c) 2023-2024 Scott Fordin (https://ohelp.com)
#  Last updated 18-12-2024
#  =====================================================================

print "\--------------------------------------------------------------------------"
print "=> This script unmounts all temporary Time Machine mounts that might be"
print "   left behind my interrupted or incomplete Time Machine runs."
print "=> This script does not touch anything in /Volumes/.timemachine or"
print "=> in /Volumes/com.apple.TimeMachine.localsnapshots."
print "=> You must run this script with root privileges (for example, with sudo)." 
print "\--------------------------------------------------------------------------"

test_privileges() {
    if [ "$UID" -eq 0 ]; then
#	print "Hello"
	intro
    else
	print "=> Permission denied. Run as root or with sudo; for example:"
	print "       sudo untime"
	all_done
    fi
}

intro() {
    print "=> The following drives will be unmounted:"
    for m in $(mount | grep -i /Volumes/.timemachine | sed -E 's:.* on /Volumes/\.timemachine/(.*)\.backup .*:/Volumes/.timemachine/\1.backup:g')
    do
	print "$m"
    done
    go_ahead
}

go_ahead() {
    print "\--------------------------------------------------------------------------"
    print -n "=> Do you want to continue (N/y)? "
    read REPLY
    if [[ $REPLY =~ ^[Yy]$ ]]; then
	for m in $(mount | grep -i /Volumes/.timemachine | sed -E 's:.* on /Volumes/\.timemachine/(.*)\.backup .*:/Volumes/.timemachine/\1.backup:g')
	do
	    sudo diskutil unmount $m
	done
        print "\--------------------------------------------------------------------------"
	print "=> Done. Here's what's mounted in /Volumes now:"
	mount | grep -i " /Volumes/"
    else
	all_done
    fi
    REPLY=""
}

all_done() {
    print "=> Goodbye."
}

# Execute this function to start things off.
test_privileges

