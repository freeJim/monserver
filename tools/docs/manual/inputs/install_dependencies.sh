# install ZeroMQ
wget http://download.zeromq.org/zeromq-2.1.4.tar.gz
tar -xzvf zeromq-2.1.4.tar.gz
cd zeromq-2.1.4/
./configure
make
sudo make install

# install sqlite3
sudo pacman -S sqlite3

