#!/bin/bash

rm sshcon.log
rm sshtimer-external.log

TRIES=100
PINGS=10
echo "id;ping-transmitted;ping-received;ping-mdev-ms;ping-avg-ms;status;dur-sec" >>sshtimer-external.log

ID="kyber768sha384-ecdsanistp384dilithium3"
read -p "Change server to '$ID' and press ENTER." </dev/tty
for i in $(seq 1 $TRIES);
do
        echo -n "$ID-$i;" >>sshtimer-external.log
        echo "$ID-$i"
        echo -n "$(ping 192.168.8.206 -q -c $PINGS | grep -E "rtt|time" | awk 'NR==1 {print $1";"$4} NR==2 {split($0, temp, "/"); split(temp[7],mdev," "); print mdev[1]";"temp[5]}' | tr "\n" ";")" >> sshtimer-external.log
        StartDate=$(date -u  +"%s.%N")
        bash timerSSH-client_pqs-external.sh >sshcon.log 2>&1
        FinalDate=$(date -u  +"%s.%N")
        echo -n "$(grep -E 'ssh: connect to host 192.168.8.206 port 4242: Connection refused|Unable to negotiate with|inet 192.168.8.206' sshcon.log | grep -Eo 'refused|Unable|inet');" >>sshtimer-external.log
        echo "$(date -u -d "0 $FinalDate sec - $StartDate sec" +"%S.%3N")" >>sshtimer-external.log

        sleep $((1 + $RANDOM % 3))s
done

ID="curve25519sha256@libssh.org-rsa"
read -p "Change server to '$ID' and press ENTER." </dev/tty
for i in $(seq 1 $TRIES);
do
        echo -n "$ID-$i;" >>sshtimer-external.log
        echo "$ID-$i"
        echo -n "$(ping 192.168.8.206 -q -c $PINGS | grep -E "rtt|time" | awk 'NR==1 {print $1";"$4} NR==2 {split($0, temp, "/"); split(temp[7],mdev," "); print mdev[1]";"temp[5]}' | tr "\n" ";")" >> sshtimer-external.log
        StartDate=$(date -u  +"%s.%N")
        bash timerSSH-client_con-external.sh >sshcon.log 2>&1
        FinalDate=$(date -u  +"%s.%N")
        echo -n "$(grep -E 'ssh: connect to host 192.168.8.206 port 4242: Connection refused|Unable to negotiate with|inet 192.168.8.206' sshcon.log | grep -Eo 'refused|Unable|inet');" >>sshtimer-external.log
        echo "$(date -u -d "0 $FinalDate sec - $StartDate sec" +"%S.%3N")" >>sshtimer-external.log

        sleep $((1 + $RANDOM % 3))s
done

ID="kyber768sha384-rsa"
read -p "Change server to '$ID' and press ENTER." </dev/tty
for i in $(seq 1 $TRIES);
do
        echo -n "$ID-$i;" >>sshtimer-external.log
        echo "$ID-$i"
        echo -n "$(ping 192.168.8.206 -q -c $PINGS | grep -E "rtt|time" | awk 'NR==1 {print $1";"$4} NR==2 {split($0, temp, "/"); split(temp[7],mdev," "); print mdev[1]";"temp[5]}' | tr "\n" ";")" >> sshtimer-external.log
        StartDate=$(date -u  +"%s.%N")
        bash timerSSH-client_hybrid-pqckex-external.sh >sshcon.log 2>&1
        FinalDate=$(date -u  +"%s.%N")
        echo -n "$(grep -E 'ssh: connect to host 192.168.8.206 port 4242: Connection refused|Unable to negotiate with|inet 192.168.8.206' sshcon.log | grep -Eo 'refused|Unable|inet');" >>sshtimer-external.log
        echo "$(date -u -d "0 $FinalDate sec - $StartDate sec" +"%S.%3N")" >>sshtimer-external.log

        sleep $((1 + $RANDOM % 3))s
done

ID="curve25519sha256@libssh.org-ecdsanistp384dilithium3"
read -p "Change server to '$ID' and press ENTER." </dev/tty
for i in $(seq 1 $TRIES);
do
        echo -n "$ID-$i;" >>sshtimer-external.log
        echo "$ID-$i"
        echo -n "$(ping 192.168.8.206 -q -c $PINGS | grep -E "rtt|time" | awk 'NR==1 {print $1";"$4} NR==2 {split($0, temp, "/"); split(temp[7],mdev," "); print mdev[1]";"temp[5]}' | tr "\n" ";")" >> sshtimer-external.log
        StartDate=$(date -u  +"%s.%N")
        bash timerSSH-client_hybrid-pqcalgo-external.sh >sshcon.log 2>&1
        FinalDate=$(date -u  +"%s.%N")
        echo -n "$(grep -E 'ssh: connect to host 192.168.8.206 port 4242: Connection refused|Unable to negotiate with|inet 192.168.8.206' sshcon.log | grep -Eo 'refused|Unable|inet');" >>sshtimer-external.log
        echo "$(date -u -d "0 $FinalDate sec - $StartDate sec" +"%S.%3N")" >>sshtimer-external.log

        sleep $((1 + $RANDOM % 3))s
done

# normalize log for german punctuation and delete english-style log
mv sshtimer-external.log temp.log
tr '.' ',' < temp.log > sshtimer-external.log
rm temp.log
