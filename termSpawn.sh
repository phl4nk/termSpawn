#!/bin/bash
# termSpawn - spawns terminal commands based on input file
# v.0.7

FILE=${@: -1}
GEO='90x15'
WORKINGDIR=`pwd`
OUTDIR=""
OUT=""
PRE=""
LOLCATS=""
HANG=";bash"

display_usage() {
  echo
  echo "Usage: $0 [OPTIONS]... [FILE]"
  echo "Spawns terminal commands based on input file. File should contain commands seperated by newline character."
  echo "The following options should not be used together [l,o]."
  echo
  echo "Optional arguments:"
  echo "  -h, help            Displays this message"
  echo "  -l, lolcat          Runs all terminals with lolcat (do not run with -o)"
  echo "  -c, close terminal  Close the terminal after command execution"
  echo "  -g, geometry        Set the terminal geometry. default=$GEO"
  echo "  -o, output dir      Redirects terminal outputs to directory in seperate files"
  exit
}

# parse options
while getopts "hlcg::o::" OPTION; do
    case $OPTION in
    h) display_usage;;
    l) LOLCATS="|lolcat";;
    c) HANG=";";;
    g) GEO=$OPTARG;;
    o) if [ -d "$OPTARG" ]; then
          OUTDIR=$OPTARG
      else
          echo "[!] Invalid output dir; Try using -h flag for help"; exit;
      fi;;
    *) echo "[!] Incorrect options provided; Try using -h flag for help";exit;;
    esac
done

# check for file in last arg, make sure its not the script as well
if [[ -z $FILE || ! -f $FILE || $FILE == $0 ]]; then
  echo
  echo "[!] Invalid commands file; Try using -h flag for help"
  exit
fi

# promt user if over 50+ terminals will be generated
WC=`wc -l $FILE | cut -d' ' -f-1`
if [ $WC -gt 50 ]; then
  read -p "This will spawn over $WC terminals, are you sure you want to procede? (Y/n) " answer
  case ${answer:0:1} in
      n|N ) exit;;
      * ) ;;
  esac
fi

#__main__
while read -r COMMAND; do
  # for the -o option
  if [ "$OUTDIR" != "" ]; then
    FILENAME=`echo $COMMAND | sed -e 's/[^A-Za-z0-9._-]/_/g'`;
    OUT=" | tee $OUTDIR$FILENAME"
  fi
  gnome-terminal --geometry=$GEO -- bash -c "cd $WORKINGDIR;$COMMAND$LOLCATS$OUT$HANG"
done < $FILE
echo "[!] Finished launching terminals"
