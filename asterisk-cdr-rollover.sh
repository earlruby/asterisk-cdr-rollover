#!/bin/bash

# asterisk-cdr-rollover
# =====================
# 
# Roll-over / move / rotate an Asterisk Master.csv call detail record (CDR) file every 15 minutes.
# Copyright (C) 2012 Earl C. Ruby III
# 
# This program is free software; you can redistribute it and/or modify it under the terms of the 
# GNU General Public License as published by the Free Software Foundation; either version 2 of 
# the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
# See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with this program; 
# if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
# MA 02111-1307 USA
# 
# The latest version of this code can be downloaded from https://github.com/earlruby/asterisk-cdr-rollover.


# Install this file in /usr/local/bin on the Asterisk server

# This script will move the Master.csv file to a new file name
# once every 15 minutes.

DATE=`date +%Y%m%d%H%M%S`
CSV_DIR=/var/log/asterisk/cdr-csv
CSV_FILE=$CSV_DIR/Master.csv

if [ -f $CSV_FILE ]; then
    mv $CSV_FILE $CSV_DIR/cdr-$DATE.csv
    touch $CSV_FILE
    chmod +r $CSV_DIR/cdr-$DATE.csv
fi
