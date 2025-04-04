# fastfetch package is available on the official repositories,
# but the pre-built version brings line wrapping, which is not
# really looks good, if your display is small

doas xbps-install cmake
git clone https://github.com/fastfetch-cli/fastfetch ~/fastfetch
cd ~/fastfetch
mkdir build
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --target fastfetch -j$(nproc)
cp ~/fastfetch/build/fastfetch /usr/bin/
rm -rf ~/fastfetch
