echo $$ > pid.file
cat lyrics.txt > temp_lyrics.txt

do_sing(){
	read -r pid < pid.file
	count=$(head -n 1 temp_lyrics.txt | grep -E "(^1\\$)|^$" | wc -l )
	while [ $count -gt 0  ]
	do
		line=$(head -n 1 temp_lyrics.txt | grep -E "(^1\\$)|^$")
		echo $line | sed "s/1\\$//g"
		cat temp_lyrics.txt | tail -n +2 > temp.txt
		cat temp.txt > temp_lyrics.txt
		count=$(head -n 1 temp.txt | grep -E "(^1\\$)|^$" | wc -l)
		sleep 1
	done
	echo $$ > pid.file
	check=$(cat temp_lyrics.txt | wc -l)
	if [ $check -eq 0 ]
	then
		kill -INT $pid
		kill -INT $$
	else
		kill -USR2 $pid
	fi
}

kill_with_grace(){
	rm pid.file
	rm temp_lyrics.txt
	rm temp.txt
	exit
}

trap "do_sing" USR1
trap "kill_with_grace" INT
trap "echo hai" KILL TERM

do_loop(){
	while [ 1 -gt 0 ]
	do
		echo ...
		sleep 1
	done
}

do_loop
