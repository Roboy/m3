export PATH=$PATH:~/workspace/m3/esp/xtensa-esp32-elf/bin
export IDF_PATH=~/workspace/m3/esp/esp-idf
idf.py build
idf.py -p /dev/ttyUSB0 flash
python -m pip install --user -r $IDF_PATH/requirements.txt
sudo apt-get install git wget libncurses-dev flex bison gperf python python-pip python-setuptools python-serial python-cryptography python-future python-pyparsing python-pyelftools cmake ninja-build ccache
