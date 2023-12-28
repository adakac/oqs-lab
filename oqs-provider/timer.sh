rm timer.log
rm temp.log

echo "id;ping-transmitted;ping-received;ping-mdev-ms;ping-avg-ms;dur-sec" >> temp.log

TRIES=1
PINGS=10

ID="CYBER786-LOCAL"
for i in $(seq 1 $TRIES);
do
        echo -n "$ID-$i;" >> temp.log
        echo ">>> $ID-$i"
        echo -n "$(ping pq.cloudflareresearch.com -q -c $PINGS | grep -E "rtt|time" | awk 'NR==1 {print $1";"$4} NR==2 {split($0, temp, "/"); split(temp[7],mdev," "); print mdev[1]";"temp[5]}' | tr "\n" ";")" >> temp.log
        StartDate=$(date -u  +"%s.%N")
        bash scripts/thesis-cloud-cyber786-local.sh
        FinalDate=$(date -u  +"%s.%N")
        echo "$(date -u -d "0 $FinalDate sec - $StartDate sec" +"%S.%3N")" >> temp.log
        sleep $((2 + $RANDOM % 7))s
done

#sleep $((1 + $RANDOM % 5))m
ID="CYBER786-GLOBAL"
for i in $(seq 1 $TRIES);
do
        echo -n "$ID-$i;" >> temp.log
        echo ">>> $ID-$i"
        echo -n "$(ping pq.cloudflareresearch.com -q -c $PINGS | grep -E "rtt|time" | awk 'NR==1 {print $1";"$4} NR==2 {split($0, temp, "/"); split(temp[7],mdev," "); print mdev[1]";"temp[5]}' | tr "\n" ";")" >> temp.log
        StartDate=$(date -u  +"%s.%N")
        bash scripts/thesis-cloud-cyber786-global.sh
        FinalDate=$(date -u  +"%s.%N")
        echo "$(date -u -d "0 $FinalDate sec - $StartDate sec" +"%S.%3N")" >> temp.log
        sleep $((2 + $RANDOM % 7))s
done

ID="X25519-LOCAL"
#sleep $((1 + $RANDOM % 5))m

for i in $(seq 1 $TRIES);
do
        echo -n "$ID-$i;" >> temp.log
        echo ">>> $ID-$i"
        echo -n "$(ping pq.cloudflareresearch.com -q -c $PINGS | grep -E "rtt|time" | awk 'NR==1 {print $1";"$4} NR==2 {split($0, temp, "/"); split(temp[7],mdev," "); print mdev[1]";"temp[5]}' | tr "\n" ";")" >> temp.log
        StartDate=$(date -u  +"%s.%N")
        bash scripts/thesis-cloud-ecdh_X25519-local.sh
        FinalDate=$(date -u  +"%s.%N")
        echo "$(date -u -d "0 $FinalDate sec - $StartDate sec" +"%S.%3N")" >> temp.log
        sleep $((2 + $RANDOM % 7))s
done

ID="X25519-GLOBAL"
#sleep $((1 + $RANDOM % 5))m

for i in $(seq 1 $TRIES);
do
        echo -n "$ID-$i;" >> temp.log
        echo ">>> $ID-$i"
        echo -n "$(ping pq.cloudflareresearch.com -q -c $PINGS | grep -E "rtt|time" | awk 'NR==1 {print $1";"$4} NR==2 {split($0, temp, "/"); split(temp[7],mdev," "); print mdev[1]";"temp[5]}' | tr "\n" ";")" >> temp.log
        StartDate=$(date -u  +"%s.%N")
        bash scripts/thesis-cloud-ecdh_X25519-global.sh
        FinalDate=$(date -u  +"%s.%N")
        echo "$(date -u -d "0 $FinalDate sec - $StartDate sec" +"%S.%3N")" >> temp.log
        sleep $((2 + $RANDOM % 7))s
done

# normalize log for german punctuation and delete english-style log
tr '.' ',' < temp.log > timer.log
rm temp.log
