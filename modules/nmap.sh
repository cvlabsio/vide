# ---= nmap scans =---
printf "$OP${IN}extened nmap script scans:$RST$RST\n"
for NMAP_STRING in $(cat $TARGETS_FILE); do
    dissect $NMAP_STRING
    if [ "$CONF" -gt 3 ] || [ -n "$FORCE_EXEC" ]; then
        l2 "$IP:$PORT script scanning on:$SVC($CONF)"
        OUT_PATH=$NMAP_DIR
        . $MODULE_PATH/nsePP.sh
        log $cmd
        $cmd
        unset cmd
        let COUNTER++
        unset {IP,PORT,CONF,SVC}
    else
        printf "\t$QP confidence is low for: $SVC on $IP:$PORT (use --force)\n"
        let COUNTER++
    fi
done
# epilog
COUNTER=1
