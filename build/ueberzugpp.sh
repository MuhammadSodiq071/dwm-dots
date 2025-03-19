git clone https://github.com/jstkdng/ueberzugpp.git
cd ueberzugpp
mkdir build && cd build
doas xbps-install cmake libvips libvips-devel libsixel libsixel-devel tbb tbb-devel chafa chafa-devel openssl openssl-devel xcb-util-image xcb-util-image-devel libopencv libopencv-devel
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
cd ..
doas cmake --install build
doas xbps-remove -R cmake libvips-devel tbb-devel chafa chafa-devel openssl-devel xcb-util-image-devel libopencv-devel
