#!/bin/bash
#ulc.sh v0.1a
#script to assist in creating usernames based on names
#Last edit 01-12-2015 11:00
VERS=$(sed -n 2p $0 | awk '{print $2}')    #Version information
LED=$(sed -n 4p $0 | awk '{print $3 " " $4}') #Date of last edit to script
#
#
#						TEH COLORZ :D
########################################################################
STD=$(echo -e "\e[0;0;0m")		#Revert fonts to standard colour/format
RED=$(echo -e "\e[1;31m")		#Alter fonts to red bold
REDN=$(echo -e "\e[0;31m")		#Alter fonts to red normal
GRN=$(echo -e "\e[1;32m")		#Alter fonts to green bold
GRNN=$(echo -e "\e[0;32m")		#Alter fonts to green normal
ORN=$(echo -e "\e[1;33m")		#Alter fonts to orange bold
ORNN=$(echo -e "\e[0;33m")		#Alter fonts to orange bold
BLU=$(echo -e "\e[1;36m")		#Alter fonts to blue bold
BLUN=$(echo -e "\e[0;36m")		#Alter fonts to blue normal
#
#
#						VARIABLES
########################################################################
SOUND=OFF
TUNE=/usr/share/sounds/freedesktop/stereo/complete.oga
COLOUR=TRUE				# FALSE = no colours, TRUE = prettified output :D
if [ "$COLOUR" == "FALSE" ] ; then
read RED REDN GRN GRNN ORN ORNN BLU BLUN  <<< ""
fi
#
#
#						WORKING FILES
########################################################################
LOC=/root/							# location for files to be saved
TMPFILE="$LOC"tmp_ulc.tmp
FIRSTTMP="$LOC"ftmp_ulc.tmp
LASTTMP="$LOC"ltmp_ulc.tmp
DOBTMP="$LOC"dob_ulc.tmp
#
#
#						HEADER
########################################################################
f_header() {
echo $BLUN"
       _            _     
 _   _| | ___   ___| |__  
| | | | |/ __| / __| '_ \ 
| |_| | | (__ _\__ \ | | |
 \__,_|_|\___(_)___/_| |_|$STD"
}
#
#
#						VERSION INFO
########################################################################
f_vers() {
clear
f_header
echo $BLUN" ulc.sh -- username list creator$STD"
echo $BLU">$STD Version information"
echo $STD
echo $STD"ulc.sh $GRN$VERS$STD Last edit $GRN$LED$STD

Written for the THS crew at www.top-hat-sec.com
Enjoy Guyz & Galz ;)"
exit
}
#
#
#							HELP
########################################################################
f_help() {
clear
f_header
echo $BLUN" ulc.sh -- username list creator$STD"
echo $BLU">$STD Help information"
echo "
Usage: ulc.sh -f [first name] -l [last name] <options>

-d   -- date (required format: dd-mm-yyyy)
-f   -- first name
-h   -- this help information
-l   -- last name
-s   -- spacer
-v   -- version
-w   -- write to file <filename>

EXAMPLES;
ulc.sh -f bob -l smith -s ! -d 01-02-1982 -w test.txt
"
exit
}
#
#DATE CHECK
#-----------
f_dob() {
if [[ ! $DOB =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]] ; then
	echo $RED">$STD date input error, must be in format dd-mm-yyyy"
	exit
else
	DOB_D=$(echo $DOB | cut -d - -f 1)
	DOB_M=$(echo $DOB | cut -d - -f 2)
	DOB_Y=$(echo $DOB | cut -d - -f 3)
	DOB_YY=$(echo $DOB_Y | cut -c 3,4)
	if [[ "$DOB_D" -lt "01" || "$DOB_D" -gt "31" ]] ; then 
	echo $RED">$STD date input error, must be in format dd-mm-yyyy"
	exit
	elif [[ "$DOB_M" -lt "01" || "$DOB_M" -gt "12" ]] ; then 
	echo $RED">$STD date input error, must be in format dd-mm-yyyy"
	exit
	fi
fi
}
#
#FIRST NAME ALTERATIONS
#----------------------
f_fname() {
	FNAME=$(echo "$FNAME" | tr '[:upper:]' '[:lower:]') 
	FNAME_I=$(echo "$FNAME" | cut -c 1)	
	echo $FNAME >> $FIRSTTMP
	echo $FNAME_I >> $FIRSTTMP
	echo $FNAME | sed 's/^./\u&/' >> $FIRSTTMP
	echo $FNAME | tr '[:lower:]' '[:upper:]' >> $FIRSTTMP
	echo $FNAME_I | tr '[:lower:]' '[:upper:]' >> $FIRSTTMP
}
#
#LAST NAME ALTERATIONS
#---------------------
f_lname() {
	LNAME=$(echo "$LNAME" | tr '[:upper:]' '[:lower:]') 	
	LNAME_I=$(echo "$LNAME" | cut -c 1)
	echo $LNAME >> $LASTTMP
	echo $LNAME_I >> $LASTTMP
	echo $LNAME | sed 's/^./\u&/' >> $LASTTMP
	echo $LNAME | tr '[:lower:]' '[:upper:]' >> $LASTTMP
	echo $LNAME_I | tr '[:lower:]' '[:upper:]' >> $LASTTMP
}
#
#FIRST/LAST NAME LIST PARSING
#----------------------------
f_parse() {
for i in $(cat $FIRSTTMP) ; do
	for x in $(cat $LASTTMP) ; do 
	echo $i >> $TMPFILE
	echo $i$x >> $TMPFILE
	done
done
for i in $(cat $LASTTMP) ; do 
	for x in $(cat $FIRSTTMP) ; do 
	echo $i >> $TMPFILE
	echo $i$x >> $TMPFILE
	done
done
}
#
#ADD DOB DATES
#--------------
f_add_dob() {
for line in $(cat $TMPFILE) ; do
	echo $line >> $DOBTMP
	echo $line$DOB_Y >> $DOBTMP
	echo $line$DOB_M$DOB_Y >> $DOBTMP
	echo $line$DOB_D$DOB_M >> $DOBTMP
	echo $line$DOB_D$DOB_M$DOB_Y >> $DOBTMP
	echo $line$DOB_Y$DOB_M >> $DOBTMP
	echo $line$DOB_Y$DOB_M$DOB_D >> $DOBTMP
	echo $line$DOB_YY >> $DOBTMP
	echo $line$DOB_M$DOB_YY >> $DOBTMP
	echo $line$DOB_D$DOB_M$DOB_YY >> $DOBTMP
	echo $line$DOB_YY$DOB_M >> $DOBTMP
	echo $line$DOB_YY$DOB_M$DOB_D >> $DOBTMP
	if [ "$SPACER" != "" ] ; then
		echo $line$SPACER$DOB_Y >> $DOBTMP
		echo $line$SPACER$DOB_M$DOB_Y >> $DOBTMP
		echo $line$SPACER$DOB_D$DOB_M$DOB_Y >> $DOBTMP
		echo $line$SPACER$DOB_Y$DOB_M >> $DOBTMP
		echo $line$SPACER$DOB_Y$DOB_M$DOB_D >> $DOBTMP
		echo $line$SPACER$DOB_YY >> $DOBTMP
		echo $line$SPACER$DOB_M$DOB_YY >> $DOBTMP
		echo $line$SPACER$DOB_D$DOB_M$DOB_YY >> $DOBTMP
		echo $line$SPACER$DOB_YY$DOB_M >> $DOBTMP
		echo $line$SPACER$DOB_YY$DOB_M$DOB_D >> $DOBTMP
	fi
done
}
#
#
#						OPTION FUNCTIONS
########################################################################
while getopts ":d:f:hl:s:vw:" opt; do
  case $opt in
    d) DOB=$OPTARG ;;
    f) FNAME=$OPTARG ;;
    h) f_help ;;
    l) LNAME=$OPTARG ;;
	s) SPACER=$OPTARG ;;
	v) f_vers ;;
	V) VERBOSE=TRUE ;;
	w) OUTFILE=$OPTARG ;;
  esac
done
#
#
#
#						INPUT/OUTPUT CHECKS
########################################################################
rm -rf "$LOC"*_ulc.tmp							# remove temp files if any remaining.
if [ $# -eq 0 ]; then clear ; f_help ; fi		# if no entries on command line show help.
if [ "$DOB" != "" ] ; then f_dob ; fi			# if date entries, check format 
#
#OUTFILE CHECKS
#-------------- 
if [ ! -z $OUTFILE ] ; then 
	if [ -f $OUTFILE ] ; then 
		read -p $RED">$STD File $OUTFILE already exists, overwrite ? Y/n " OVERWRITE
		if [[ "$OVERWRITE" == "n" || "$OVERWRITE" == "N" ]] ; then exit ; fi
	fi
fi
#
#
#START SCRIPT
#------------
if [[ "$FNAME" != "" && "$LNAME" != "" ]] ; then 
	f_fname
	f_lname
	f_parse
	if [ "$DOB" != "" ] ; then f_add_dob ; fi
elif [[ "$FNAME" == "" && "$LNAME" != "" ]] ; then f_lname ; cat $LASTTMP > $TMPFILE
	if [ "$DOB" != "" ] ; then f_add_dob ; fi
elif [[ "$FNAME" != "" && "$LNAME" == "" ]] ; then f_fname ; cat $FIRSTTMP > $TMPFILE
	if [ "$DOB" != "" ] ; then f_add_dob ; fi
fi
#
#
if [ "$DOB" != "" ] ; then 
	if [ ! -z $OUTFILE ] ; then cat "$TMPFILE" "$DOBTMP" | sort | uniq > $OUTFILE 
	elif [ -z $OUTFILE ] ; then cat "$TMPFILE" "$DOBTMP" | sort | uniq
	fi
elif [ "$DOB" == "" ] ; then
	if [ ! -z $OUTFILE ] ; then cat "$TMPFILE" | sort | uniq > $OUTFILE 
	elif [ -z $OUTFILE ] ; then cat "$TMPFILE" | sort | uniq
	fi
fi
