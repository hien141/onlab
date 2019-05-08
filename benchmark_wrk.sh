#!/usr/bin/env bash
#Requirements:
#<function name without dashes>.wrk descriptor file for wrk
#<function name without dashes>.body (even if you don't need it)

#Configuration variables
functions=(hhellogo hhellojava) #hhellopython hmatrixjava hmatrixpython hprimjava hprimpython)
connections=(1000)
times=(1m)
kuberhost="node1:32211"
threads=40

WRK_INSTALLED=$(command -v wrk)
if [[ $WRK_INSTALLED = "" ]]
then
        apt update
        apt install build-essential libssl-dev git -y
        git clone https://github.com/wg/wrk.git wrk
        cd wrk || exit
        make
        cp wrk /usr/local/bin
fi

echo -e "Benchmarking functions\n"
for function in "${functions[@]}"
do
    echo -e "Benchmarking $function\n"
#    echo -e "Output of $function is:\n"
 #   echo -e "\n"
        for connection in "${connections[@]}"
        do
            echo -e "Threads: $threads Connections $connection\n"
                for time in "${times[@]}"
        	do
                    datetime=$(date '+%Y-%m-%d-%H-%M-%S')
                    echo -e "Time: $time\n"
                    echo -e "wrk $datetime\n"
                    wrk -c"$connection" -d"$time" -t"$threads" --latency http://"$kuberhost"/"$function" > ./data/"$function"."$connection"."$time"."$datetime".txt 2>&1
            	done
        done
done
