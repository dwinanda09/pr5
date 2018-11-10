read -r pid < pid.file
do_sing(){
	read -r pid < pid.file
	echo $$ > pid.file
        count=$(head -n 1 temp_lyrics.txt | grep -E "(^2\\$)|^$" | wc -l )
        while [ $count -gt 0  ]
        do

                line=$(head -n 1 temp_lyrics.txt | grep -E "(^2\\$)|^$")
                echo $line | sed "s/2\\$//g"
                cat temp_lyrics.txt | tail -n +2 > temp.txt
                cat temp.txt > temp_lyrics.txt
                count=$(head -n 1 temp.txt | grep -E "(^2\\$)|^$" | wc -l)
                sleep 1
        done
	kill -s USR1 $pid
}

kill_with_grace(){
        exit
}

trap "do_sing" USR2
trap "kill_with_grace" INT

do_loop(){
        while [ 1 -gt 0 ]
        do
                sleep 1
		echo ...
        done
}
echo $$ > pid.file
kill -s USR1 $pid
do_loop

