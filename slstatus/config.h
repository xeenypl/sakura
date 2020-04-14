const unsigned int interval = 1000;
static const char unknown_str[] = "";
#define MAXLEN 2048

/* battery_perc        battery percentage              battery name (BAT0)
 * battery_state       battery charging state          battery name (BAT0)
 * battery_remaining   battery remaining HH:MM         battery name (BAT0) */
static const struct arg args[] = {
  { battery_state,     "%s",  "BAT0" },
  { battery_perc,      "%s ", "BAT0" },
  { battery_remaining, "%s ", "BAT0" },
  { run_command,       "%s ", "amixer get Master | tail -n1 | sed -r 's/.*\\[(.*)%\\].*/\\1/'" },
	{ datetime,          "%s",  "%F %T" },
};
