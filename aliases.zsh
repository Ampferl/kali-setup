alias copy='xclip -sel clip'
alias toolkit="python3 ~/.toolkit/toolkit.py"

export myip=$(ifconfig eth0 | grep "inet " | awk "{print \$2}")
