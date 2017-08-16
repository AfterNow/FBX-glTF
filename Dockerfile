FROM ubuntu:14.04

RUN apt-get update && \
    apt-get install -y g++-4.8 g++ git make libboost1.54-all-dev libssl-dev cmake
RUN git clone https://git.codeplex.com/casablanca
RUN cd casablanca/Release &&\
   mkdir build.release &&\
   cd build.release &&\
   CXX=g++-4.8 cmake .. -DCMAKE_BUILD_TYPE=Release &&\
   make &&\
   sudo make install

#SHOULD go at the top

RUN apt-get install -y software-properties-common && add-apt-repository ppa:george-edison55/cmake-3.x &&\
    apt-get update -y &&\
    apt-get remove -y cmake cmake-data &&\
    apt-get install -y cmake wget expect

RUN wget http://download.autodesk.com/us/fbx/2018/2018.1.1/fbx20181_1_fbxsdk_linux.tar.gz &&\
   tar -xvzf fbx20181_1_fbxsdk_linux.tar.gz &&\
   chmod ugo+x fbx20181_1_fbxsdk_linux
    
COPY . /FBX-glTF

RUN expect -f ./FBX-glTF/maya-install.expect
RUN cmake .. -DCMAKE_BUILD_TYPE=Release -DFBX_SDK=/usr/include/fbxsdk
