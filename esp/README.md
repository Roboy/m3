export PATH=$PATH:~/workspace/m3/esp/xtensa-esp32-elf/bin
export IDF_PATH=~/workspace/m3/esp/esp-idf
idf.py build
idf.py -p /dev/ttyUSB0 flash
