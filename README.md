# UNTIME

This script unmounts temporary Time Machine mounts that might be left behind by interrupted or incomplete Time Machine runs.

Note the following:

* This script is intended only for MacOS.
* The Time Machine mounts are referenced relative to the default MacOS user mount directory; for example, `/Volumes/`_\<mount_dir\>_.
* The Time Machine mounts are *not* referenced by their device directory or network share names; for example, `/dev/disk`_\<nn\>_ or `//`_\<server_name\>_`/`_\<share_name\>_.
* The only affected mounts are those that are named using the default temporary pattern `/Volumes/.timemachine`_\<name\>_`.backup`.
* The script does not touch anything in `/Volumes/.timemachine` or in `/Volumes/com.apple.TimeMachine.localsnapshots`.
* You must run this script as root or with sudo.

Copyright &copy; 2023-2024 Scott Fordin (https://ohelp.com)
Last updated December 18, 2024
