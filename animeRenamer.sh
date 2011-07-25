#!/bin/bash
#ll | sed "s| |;|g" | cut -d ';' -f 10


if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ $1 = "-h" ]; then
  echo "Use anime renamer like this:
  ./animeRenamer.sh DIRECTORY FILENAME NUMBER_POSITION
  Where:
  - DIRECTORY is the place where your animes are,
  - FILENAME the name of the output file,
  - NUMBER_POSITION the position of the episode number.

  For exemple:
    If the files are like that:
    Haruhi Suzumiya S2 23 [HD].mp4
    [lalal] Haruhi_Suzumiya S2_24 [HD].mp4

    ./animeRenamer.sh ../Document/Anime/Haruhi Haruhi_Suzumiya_S2 2

    It will result on :

    Haruhi_Suzumiya_S2_23.mp4
    Haruhi_Suzumiya_S2_24.mp4

    /!\WARNING/!\ If your epsiodes numbers are not at the same place in all the files, it will create problems.
    So please be carreful
    /!\WARNING/!\
      "

  else

    Directory=$1
    FileName=$2
    EpisodePosition=$(($3+1))

    cd $Directory

    for FILE in "./"* ; do

      # Check if $FILE is a regular file
      if [ -f "$FILE" ]; then
        # Check if the regular file is readable

        OldFileName=`echo $FILE | sed 's|./||g' | sed 's| ||g'`

        FileBody=`echo $OldFileName | cut -d . -f 1`
        FileExtension=`echo $OldFileName | cut -d . -f 2`

        # Find the number in the string
        FileNumber=`echo $FileBody | sed "s/[^0-9*]/_/g" | sed "s|__*|_|g" | cut -d _ -f $EpisodePosition`

        NewFileName=$FileName"_"$FileNumber"."$FileExtension
        echo "It will rename :  $OldFileName      into      $NewFileName"

        read -p "Are you sure? " -n 1
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          # do dangerous stuff
          echo ""
          mv $OldFileName $NewFileName
          echo "$OldFileName renamed into $NewFileName"
        else
          echo ""
          read -p "Please enter the new name: "
          echo ""
          mv $OldFileName $REPLY
          echo "$OldFileName renamed into $REPLY"
        fi
      fi
      # End of our for statement
    done

  fi


