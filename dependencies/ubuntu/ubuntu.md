sudo apt install fzf fd-find ripgrep cmake libevdev-dev libudev-dev libyaml-cpp-dev libboost-dev pkg-config unzip cargo

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit
rm lazygit.tar.gz

git clone https://gitlab.com/interception/linux/tools.git
git clone --depth 1 https://gitlab.com/interception/linux/plugins/caps2esc.git

cd tools
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
cd build
sudo make install
cd ..
cd ..
sudo rm -rf tools


cd caps2esc
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
cd build
sudo make install
cd ..
cd ..
sudo rm -rf caps2esc

sudo cp udevmon.yaml /etc/
sudo cp udevmon.service /etc/systemd/system/
sudo systemctl enable --now udevmon
