echo "You MUST run this script when inside the folder ativ-3-exp-1"
scriptDir=$('pwd')



cd ../../       # go to repo root
cd build/debug/bin # go to build dir
ls
echo "" > output.log

cd $scriptDir
cd ../../       # go to repo root
cd build/release/bin # go to build dir
echo "" > output.log
cd $scriptDir
sensors > temp_output.log

for ((a=0; a <= 10000; a++))
do
    echo "DEBUG RUN $a"
    cd $scriptDir
    date >> temp_output.log
    sensors >> temp_output.log
    cd ../../       # go to repo root
    cd build/debug/bin # go to build dir
    date >> output.log
    ./gmx mdrun -v -deffnm em >> output.log
    cd $scriptDir
    cd ../../       # go to repo root
    cd build/release/bin # go to build dir
    date >> output.log
    ./gmx mdrun -v -deffnm em >> output.log
    cd $scriptDir
done



