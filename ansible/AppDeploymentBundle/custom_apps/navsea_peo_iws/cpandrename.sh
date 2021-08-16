for f in /splunkdata/DataCollect.*/*/CaaSmgenActor.log;
do
s=${f##/splunkdata/}
s=$(echo $s | sed -r 's/[/]+/./g')
cp $f ./samples/${s}
done

