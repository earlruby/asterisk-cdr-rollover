asterisk-cdr-rollover
=====================

Roll-over / move / rotate an Asterisk Master.csv call detail record (CDR) file every 15 minutes.

Copyright (C) 2012 Earl C. Ruby III

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

The latest version of this code can be downloaded from https://github.com/earlruby/asterisk-cdr-rollover.

Purpose
=======

If you are trying to provide CDR files to a billing service, such as WebCDR.com, you need to provide files containing your latest call data every 15 minutes or so. These scripts create a new CDR file every 15 minutes with the latest CDR records, without interrupting call flow.  You do not need to make any changes to your Asterisk configuration to use these scripts.

Setup
=====

There are two files that you need to install on your Asterisk server:

 * asterisk-cdr-rollover.sh - A bash shell script. Copy this file into /usr/local/sbin.  This script moves the file /var/log/asterisk/cdr-csv/Master.csv to a new file named /var/log/asterisk/cdr-csv/cdr-YYYYMMDDHHMISS.csv, where YYYYMMDDHHMISS is the current time. A new zero-byte Master.csv file is created using the default umask of the user running the asterisk process. Asterisk will start writing to the new Master.csv file at the end of the next call.

 * asterisk-cdr-rollover - This is a cron job. Copy it into /etc/cron.d and it will run the /usr/local/sbin/asterisk-cdr-rollover.sh script once every 15 minutes.

The cron job is set up to run as the user "asterisk". If you are running asterisk as "root" or some other user name, edit the asterisk-cdr-rollover cron job and change the name of the user running the script to the same name as the user running the asterisk process.

Why not use logrotate?
======================

Four reasons not to use logrotate:

 1. logrotate does not provide log rotation every 15 minutes.
 2. logrotate will not create unique file names unless you use a date format in the name (file names with a .nnn extension get reused over time), but since logrotate only supports YYYYMMDD, not hours, minutes, or seconds, once again you're limited to daily roll-overs. (asterisk-cdr-rollover generates file names using the format cdr-YYYYMMDDHHMISS.csv.)
 3. My customers need to be able to feed CDR files into a telecom billing, monitoring, fraud-detecting system I work on called https://www.WebCDR.com, which works best if it gets a new CDR file every fifteen minutes.
 4. If there are no calls after 15 minutes, with asterisk-cdr-rollover I get a zero byte file, which can trigger a "no calls" alarm, alerting me that something is wrong with the Asterisk switch. (The switch setup I'm working will always have some calls within a 15 minute block if everything is working correctly, although people with less-busy switches can always configure a larger alarm window to suit their situations.) If you're running a high-traffic switch, this can be a life-saver.

If you want a copy, go to https://github.com/earlruby/asterisk-cdr-rollover and click the ZIP button to download the script and cron job. It's free. 
