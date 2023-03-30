# ---= bins =--- #CHANGE ME
NMAP=/usr/bin/nmap
XMLS=/usr/bin/xmlstarlet
NIKTO=/usr/bin/nikto
WW=/usr/bin/whatweb
WA=/usr/local/bin/webanalyze
GVV=$GO_PATH/bin/goverview
FFUF=$GO_PATH/bin/ffuf
BYP4=$GO_PATH/bin/byp4xx
SUBJS=$GO_PATH/bin/subjs
HTTPX=$HOME/.pdtm/go/bin/httpx
NUCLEI=$HOME/.pdtm/go/bin/nuclei
KATANA=$HOME/.pdtm/go/bin/katana

# ---= check =---
if [ -n "$CHECK" ]; then
 	GIT_REL="$(git log --format='%h %ci' -1 2>/dev/null | awk '{ print $1" "$2" "$3 }')"
	echo "running build $GIT_REL"
	SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
	printf "checking $SCRIPTPATH/config.sh\n"
	# ---= path =---
	if [  -n "$HOME" ];		then printf "${OP}${BD}HOME${RST}	set ($HOME)\n"; 		else printf "${EP}${BD}HOME${RST} not exported.\n"; fi
	if [  -n "$GO_PATH" ];	then printf "${OP}${BD}GO_PATH${RST}	set ($GO_PATH)\n"; 	else printf "${EP}${BD}GO_PATH${RST} not exported.\n"; fi
	printf -- '-%.0s' {1..35}; printf "\n"
	# ---= bins =---
	if [  -f "$NMAP" ];		then printf "${OP}${BD}nmap${RST}	is installed.\n"; 		else printf "${EP}${BD}nmap${RST}	not found under: $NMAP\n"; fi
	if [  -f "$XMLS" ];		then printf "${OP}${BD}xmlstarlet${RST}	is installed.\n"; 	else printf "${EP}${BD}xmlstarlet${RST}	not found under: $XMLS\n"; fi
	if [  -f "$NIKTO" ];	then printf "${OP}${BD}nikto${RST}	is installed.\n"; 		else printf "${EP}${BD}nikto${RST}	not found under: $NIKTO\n"; fi
	if [  -f "$WW" ];		then printf "${OP}${BD}WhatWeb${RST}	is installed.\n"; 	else printf "${EP}${BD}WhatWeb${RST}	not found under: $WW\n"; fi
	if [  -f "$GVV" ];		then printf "${OP}${BD}goverview${RST}	is installed.\n"; 	else printf "${EP}${BD}goverview${RST}	not found under: $GVV\n"; fi
	if [  -f "$FFUF" ];		then printf "${OP}${BD}ffuf${RST}	is installed.\n"; 		else printf "${EP}${BD}ffuf${RST}	not found under: $FFUF\n"; fi
	if [  -f "$BYP4" ];		then printf "${OP}${BD}byp4xx${RST}	is installed.\n"; 		else printf "${EP}${BD}byp4xx${RST}	not found under: $BYP4\n"; fi
	if [  -f "$SUBJS" ];	then printf "${OP}${BD}subjs${RST}	is installed.\n"; 		else printf "${EP}${BD}subjs${RST}	not found under: $SUBJS\n"; fi
	if [  -f "$HTTPX" ];	then printf "${OP}${BD}httpx${RST}	is installed.\n"; 		else printf "${EP}${BD}httpx${RST}	not found under: $HTTPX\n"; fi
	if [  -f "$NUCLEI" ];	then printf "${OP}${BD}nuclei${RST}	is installed.\n"; 		else printf "${EP}${BD}nuclei${RST}	not found under: $NUCLEI\n"; fi
	if [  -f "$KATANA" ];	then printf "${OP}${BD}katana${RST}	is installed.\n"; 		else printf "${EP}${BD}katana${RST}	not found under: $KATANA\n"; fi
	exit 0
fi

# ---= config =---
VERSION=2.0
timestamp=$(date +%d.%m_%H%M)
COUNTER=1
THREADS=40
SCAN_HEADER="github.com/dreizehnutters/vide"
WORK_DIR="$PROJECT_DIR/vide_$timestamp"
NMAP_PATH="$PROJECT_DIR/nmap"
WS_FILE="$WORK_DIR/webservers.txt"
HTTPS_SERVERS="$WORK_DIR/https_servers.txt"
HTTP_SERVERS="$WORK_DIR/http_server.txt"
CANDIDATES_FILE="$NMAP_PATH/host_port.txt"
NMAP_PARSE="$NMAP_PATH/parsed.txt"
mkdir -p "$WORK_DIR"


# ---= template =---
TEMPLATE_DIR="$WORK_DIR/template"
[ -n "$DO_TEMPLATE" ]       && mkdir -p "$TEMPLATE_DIR"


# ---= webanalyze =---
CRAWL_DEPTH=0
WA_JSON="$HOME/tools/technologies.json" #CHANGE ME
WA_DIR="$WORK_DIR/webanalyze"
[ -n "$DO_WA" ]         && mkdir -p "$WA_DIR"


# ---= 40X =---
BYP4_DIR="$WORK_DIR/bypass40X"
[ -n "$DO_404" ]         && mkdir -p "$BYP4_DIR"


# ---= nmap =---
NMAP_DIR="$WORK_DIR/nmap_scripts"
[ -n "$DO_NMAP" ]         && mkdir -p "$NMAP_DIR"


# ---= nikto =---
NIKTO_TUNING="-Tuning x567"
NIKTO_DIR="$WORK_DIR/nikto"
[ -n "$DO_NIKTO" ]        && mkdir -p "$NIKTO_DIR"

# ---= screenshots =---
SS_TIMEOUT=50
SCREEN_DIR="$WORK_DIR/screens"
[ -n "$DO_SCREENSHOTS" ]  && mkdir -p "$SCREEN_DIR"


# ---= httpX =---
RATE_LIMIT=100
HTTPX_DIR="$WORK_DIR/httpx"
HTTPX_LOG="$HTTPX_DIR/scan.log"
[[ -z "$DO_NMAP" || $NUM_FLAGS -gt 1 ]] && mkdir -p "$HTTPX_DIR"


# ---= whatweb =---
WHATWEB_LEVEL=3
CUSTOM_HEADER="TMP:"
WW_DIR="$WORK_DIR/whatweb"
[ -n "$DO_WHATWEB" ]      && mkdir -p "$WW_DIR"


# ---= nuclei =---
NUCLEI_DIR="$WORK_DIR/nuclei"
NUCLEI_TEMPLATES="$HOME/tools/nuclei-templates" #CHANGE ME


# ---= ffuf =---
FFUF_DIR="$WORK_DIR/ffuf"
WORDLIST="/opt/goto.wordlist" #CHANGE ME
[ -n "$DO_FFUF" ]         && mkdir -p "$FFUF_DIR"


# ---= katana =---
KATANA_DIR="$WORK_DIR/katana"
[ -n "$DO_KATANA" ]       && mkdir -p "$KATANA_DIR"