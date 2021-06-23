for iteration in {1..10000}; do

echo $iteration
qsub -o DiceQCall$iteration.o.txt -e DiceQCall$iteration.e.txt DiceQCall.sh $iteration
#sleep 6

done


