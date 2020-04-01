echo "You MUST run this script when inside the folder ativ-3-exp-1"
scriptDir=$('pwd')



# get simulation info
cd input
simulationInputFolder=$('pwd')
wget https://files.rcsb.org/view/6LVN.pdb # molecular information

### gen simulation
genSim() {
    echo "15" | ./gmx pdb2gmx -f $simulationInputFolder/6LVN.pdb -o 6LVN_processed.gro -water spce
    ./gmx editconf -f 6LVN_processed.gro -o 6LVN_newbox.gro -c -d 1.0 -bt cubic
    ./gmx solvate -cp 6LVN_newbox.gro -cs spc216.gro -o 6LVN_solv.gro -p topol.top
    ./gmx grompp -f $simulationInputFolder/ions.mdp -c 6LVN_solv.gro -p topol.top -o ions.tpr
    echo "13" | ./gmx genion -s ions.tpr -o 6LVN_solv_ions.gro -p topol.top -pname NA -nname CL -neutral
    ./gmx grompp -f $simulationInputFolder/ions.mdp -c 6LVN_solv_ions.gro -p topol.top -o em.tpr
}

echo "Building gromax (type: debug)"
# build debug version
cd $scriptDir
cd ../../       # go to repo root
rm -rf build/   # delete old build
mkdir -p build/debug/
cd build/debug # go to build dir
cmake ../../ -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON -DGMX_GPU=off -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++
make -j 4
cd bin
ls
genSim # generate simulation



echo "Building gromax (type: release)"
# build debug version
cd $scriptDir
cd ../../       # go to repo root
mkdir -p build/release/
cd build/release # go to build dir
cmake ../../ -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON -DGMX_GPU=off -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++
make -j 4
cd bin
ls
genSim # generate simulation

echo "Ready to run!"
