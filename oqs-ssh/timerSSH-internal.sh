#!/bin/bash

rm sshcon.log
rm sshtimer-internal.log

TRIES=100
PINGS=10
echo "id;ping-transmitted;ping-received;ping-mdev-ms;ping-avg-ms;status;dur-sec" >>sshtimer-internal.log

# start ssh-server
bash timerSSH-server_pqs.sh &
# wait till available
sleep $((2 + $RANDOM % 3))s


ID="kyber768sha384-ecdsanistp384dilithium3"
for i in $(seq 1 $TRIES);
do
        echo -n "$ID-$i;" >>sshtimer-internal.log
        echo "$ID-$i"
        echo -n "$(ping 127.0.0.1 -q -c $PINGS | grep -E "rtt|time" | awk 'NR==1 {print $1";"$4} NR==2 {split($0, temp, "/"); split(temp[7],mdev," "); print mdev[1]";"temp[5]}' | tr "\n" ";")" >> sshtimer-internal.log
        StartDate=$(date -u  +"%s.%N")
        bash timerSSH-client_pqs-internal.sh >sshcon.log 2>&1
        FinalDate=$(date -u  +"%s.%N")
        echo -n "$(grep -E 'ssh: connect to host 127.0.0.1 port 4242: Connection refused|Unable to negotiate with|inet 192.168.8.205' sshcon.log | grep -Eo 'refused|Unable|inet');" >>sshtimer-internal.log
        echo "$(date -u -d "0 $FinalDate sec - $StartDate sec" +"%S.%3N")" >>sshtimer-internal.log

        sleep 1s
done

# kill server
server_pid="$(ps | grep sshd | awk '{print $1}')"
echo "ServerID is $server_pid"
kill $server_pid
sleep $((2 + $RANDOM % 3))s
# start ssh-server
bash timerSSH-server_con.sh &
# wait till available
sleep $((2 + $RANDOM % 3))s

ID="curve25519sha256@libssh.org-rsa"
for i in $(seq 1 $TRIES);
do
        echo -n "$ID-$i;" >>sshtimer-internal.log
        echo "$ID-$i"
        echo -n "$(ping 127.0.0.1 -q -c $PINGS | grep -E "rtt|time" | awk 'NR==1 {print $1";"$4} NR==2 {split($0, temp, "/"); split(temp[7],mdev," "); print mdev[1]";"temp[5]}' | tr "\n" ";")" >> sshtimer-internal.log
        StartDate=$(date -u  +"%s.%N")
        bash timerSSH-client_con-internal.sh >sshcon.log 2>&1
        FinalDate=$(date -u  +"%s.%N")
        echo -n "$(grep -E 'ssh: connect to host 127.0.0.1 port 4242: Connection refused|Unable to negotiate with|inet 192.168.8.205' sshcon.log | grep -Eo 'refused|Unable|inet');" >>sshtimer-internal.log
        echo "$(date -u -d "0 $FinalDate sec - $StartDate sec" +"%S.%3N")" >>sshtimer-internal.log

        sleep 1s
done

# kill server
server_pid="$(ps | grep sshd | awk '{print $1}')"
echo "ServerID is $server_pid"
kill $server_pid
sleep $((2 + $RANDOM % 3))s
# start ssh-server
bash timerSSH-server_hybrid-pqckex.sh &
# wait till available
sleep $((2 + $RANDOM % 3))s


ID="kyber768sha384-rsa"
for i in $(seq 1 $TRIES);
do
        echo -n "$ID-$i;" >>sshtimer-internal.log
        echo "$ID-$i"
        echo -n "$(ping 127.0.0.1 -q -c $PINGS | grep -E "rtt|time" | awk 'NR==1 {print $1";"$4} NR==2 {split($0, temp, "/"); split(temp[7],mdev," "); print mdev[1]";"temp[5]}' | tr "\n" ";")" >> sshtimer-internal.log
        StartDate=$(date -u  +"%s.%N")
        bash timerSSH-client_hybrid-pqckex-internal.sh >sshcon.log 2>&1
        FinalDate=$(date -u  +"%s.%N")
        echo -n "$(grep -E 'ssh: connect to host 127.0.0.1 port 4242: Connection refused|Unable to negotiate with|inet 192.168.8.205' sshcon.log | grep -Eo 'refused|Unable|inet');" >>sshtimer-internal.log
        echo "$(date -u -d "0 $FinalDate sec - $StartDate sec" +"%S.%3N")" >>sshtimer-internal.log

        sleep 1s
done

# kill server
server_pid="$(ps | grep sshd | awk '{print $1}')"
echo "ServerID is $server_pid"
kill $server_pid
sleep $((2 + $RANDOM % 3))s
# start ssh-server
bash timerSSH-server_hybrid-pqcalgo.sh &
# wait till available
sleep $((2 + $RANDOM % 3))s


ID="curve25519sha256@libssh.org-ecdsanistp384dilithium3"
for i in $(seq 1 $TRIES);
do
        echo -n "$ID-$i;" >>sshtimer-internal.log
        echo "$ID-$i"
        echo -n "$(ping 127.0.0.1 -q -c $PINGS | grep -E "rtt|time" | awk 'NR==1 {print $1";"$4} NR==2 {split($0, temp, "/"); split(temp[7],mdev," "); print mdev[1]";"temp[5]}' | tr "\n" ";")" >> sshtimer-internal.log
        StartDate=$(date -u  +"%s.%N")
        bash timerSSH-client_hybrid-pqcalgo-internal.sh >sshcon.log 2>&1
        FinalDate=$(date -u  +"%s.%N")
        echo -n "$(grep -E 'ssh: connect to host 127.0.0.1 port 4242: Connection refused|Unable to negotiate with|inet 192.168.8.205' sshcon.log | grep -Eo 'refused|Unable|inet');" >>sshtimer-internal.log
        echo "$(date -u -d "0 $FinalDate sec - $StartDate sec" +"%S.%3N")" >>sshtimer-internal.log

        sleep 1s
done

# kill server
server_pid="$(ps | grep sshd | awk '{print $1}')"
echo "ServerID is $server_pid"
kill $server_pid

# normalize log for german punctuation and delete english-style log
mv sshtimer-internal.log temp.log
tr '.' ',' < temp.log > sshtimer-internal.log
rm temp.log
