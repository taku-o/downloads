#!/bin/sh
########################
#
# shell script to change terminal color.
# for osx, zsh or bash.
#
# source this script in your terminal configuration file.
# for example,
# . ch_term_color.sh
#
#
# color name list
# "red", "green", "blue", "cyan", "magenta", "yellow", "purple", "black"
#
#
# advweb@jcom.home.ne.jp
# http://members.jcom.home.ne.jp/advweb/
#
########################

# get last char
lc=$(tty | sed -e 's#.*\(.\)$#\1#')

# switch case
case ${lc} in
	1|5|9|d)
		background="black"
		cursor="green"
		normal_text="yellow"
		bold_text="red"
	;;
	2|6|a|e)
		background="red"
		cursor="black"
		normal_text="green"
		bold_text="yellow"
	;;
	3|7|b|f)
		background="yellow"
		cursor="red"
		normal_text="black"
		bold_text="green"
	;;
	4|8|c|0)
		background="green"
		cursor="yellow"
		normal_text="red"
		bold_text="black"
	;;
	*)
		echo "unknown tty last char"
		exit 1
	;;
esac

# run applescript
osascript << EOF
tell application "Terminal"
	tell window 1
		set background color to "${background}"
		set cursor color to "${cursor}"
		set normal text color to "${normal_text}"
		set bold text color to "${bold_text}"
	end tell
end tell
EOF

