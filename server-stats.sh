awk '/^cpu /{
  usage=($2+$4)*100/($2+$4+$5)
  printf("CPU Usage: %.2f%%\n", usage)
}' /proc/stat

awk '
/^MemTotal:/ { total=$2 }
/^MemAvailable:/ { available=$2 }
END {
  used = total - available
  printf "Memory Usage: %.2f%% (%d MB / %d MB)\n",
         used*100/total, used/1024, total/1024
}' /proc/meminfo

df -h /c | awk 'NR==2 {
  printf "Disk Usage (C:): %s used of %s (%s)\n", $3, $2, $5
}'

echo 'Top 5 CPU Usage:'
ps -eo pid,comm,%cpu --sort=%cpu | tail -5

echo 'Top 5 memory usage:'
ps -eo pid,comm,%mem --sort=%mem | tail -5




