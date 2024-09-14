#cmake -U
#rm CMakeCache.txt
cmake -DCMAKE_BUILD_TYPE=DEBUG -lpthread ..
cmake --build . --config Debug --parallel
