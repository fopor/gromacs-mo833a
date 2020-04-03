echo "You MUST run this script when inside the folder ativ-3-exp-1"
scriptDir=$('pwd')



cd ../../       # go to repo root
cd build/debug/bin # go to build dir
ls
echo "" > output.log

for ((a=0; a <= 10000; a++))
do
    ./gmx mdrun -v -deffnm em >> output.log
done

cd $scriptDir
cd ../../       # go to repo root
cd build/release/bin # go to build dir
for ((a=0; a <= 10000; a++))
do
./gmx mdrun -v -deffnm em
done

