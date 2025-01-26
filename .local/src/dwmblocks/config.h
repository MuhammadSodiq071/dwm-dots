//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	//Icon, Command, UpdateInterval, UpdateSignal
  { "┇  ", "xset -q|grep LED| awk '{ if (substr ($10,5,1) == 1) print \"[RU]\"; else print \"[EN]\"; }'", 0, 1 },
	{ "", "volume.sh", 0, 1 },
	{ "", "mic.sh", 0, 1 },
  { "", "battery.sh", 300, 1 },
  { "  ", "free -h | awk '/^Mem/ { print $3 }'",	300, 1 },
  { "  ", "date '+%d.%m'", 60, 0 },
  { "  ", "date '+%H:%M'", 5, 0},
};

//Sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char *delim = "  ┇  ";
static unsigned char delimLen = 7;

// Have dwmblocks automatically recompile and run when you edit this file in
// vim with the following line in your vimrc/init.vim:

// autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
