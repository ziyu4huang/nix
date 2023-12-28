sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev pkg-config  libgdbm-compat-dev uuid-dev lzma-dev liblzma-dev tk-dev

./configure --enable-optimizations --prefix=$HOME/python311
make -j 12
sudo make altinstall
