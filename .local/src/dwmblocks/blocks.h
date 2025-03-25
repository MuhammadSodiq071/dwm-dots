//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/ 
  {"┇  ", "xset -q|grep LED| awk '{ if (substr ($10,5,1) == 1) print \"[RU]\"; else print \"[EN]\"; }'", 0, 1 },
  {"", "volume.sh", 0, 2 },
  {"", "mic.sh", 0, 3 },
  {"", "battery.sh", 300, 10 },
  {"󰯍  ", "free -h | awk '/^Swap/ { print $3 }' | tr -d i", 300, 10 },
  {"", "free -h | awk '/^Mem/ { print \"  \" $3 }' | tr -d i", 60, 10 },
  {"  ", "date '+%d.%m'", 60, 0 },
  {"  ", "date '+%H:%M'", 5, 0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = "  ┇  ";
static unsigned int delimLen = 7;
