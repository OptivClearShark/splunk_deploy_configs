#/bin/bash

for sample in ./samples/*reference-short-delay*; do
  s=$(echo $sample | awk -F '/' '{print $3}')
  h=$(echo $sample | awk -F '.' '{print $5}')
  echo "
[$s]
host=$h
mode=sample
disabled = false
timeMultiple = 1
interval=120
index = peo_eventgen
source = CaaSmgenActor.log
sourcetype = caasmgenactor
## replace timestamp 03/11/10 01:12:01 PM
token.0.token = ^\d{2,4}-\d{2}-\d{2}\s\d{1,2}:\d{1,2}:\d{1,2}
token.0.replacementType = timestamp
token.0.replacement = %Y-%m-%d %H:%M:%S
earliest = -2m
latest = now


" >> ./eventgen.conf

done

for sample in ./samples/*reference-static-short-delay*; do
  s=$(echo $sample | awk -F '/' '{print $3}')
  h=$(echo $sample | awk -F '.' '{print $5}')
  echo "
[$s]
host=$h
delay=60
mode=sample
disabled = false
timeMultiple = 1
interval=120
index = peo_eventgen
source = CaaSmgenActor.log
sourcetype = caasmgenactor
## replace timestamp 03/11/10 01:12:01 PM
token.0.token = ^\d{2,4}-\d{2}-\d{2}\s\d{1,2}:\d{1,2}:\d{1,2}
token.0.replacementType = timestamp
token.0.replacement = %Y-%m-%d %H:%M:%S
earliest = -2m
latest = now


" >> ./eventgen.conf

done
