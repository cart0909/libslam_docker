# This is an auto generated Dockerfile for ros:desktop-full
# generated from docker_images/create_ros_image.Dockerfile.em
FROM osrf/ros:melodic-desktop-bionic

# install ros packages
RUN apt-get update && apt-get install -y \
    ros-melodic-desktop-full=1.4.1-0*

# nvidia-docker2
# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt-get install python-catkin-tools -y
RUN apt-get install libgoogle-glog-dev libgtest-dev -y 
RUN apt-get install libmetis-dev -y # for gtsam

RUN git clone --recursive https://github.com/cart0909/libslam_env
WORKDIR libslam_env
RUN catkin init &&\
    catkin config -e /opt/ros/melodic/ --install -i /usr/local &&\
    catkin build

WORKDIR /
RUN rm -rf libslam_env/ &&\
    echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc &&\
    echo "source /usr/local/setup.bash" >> ~/.bashrc

RUN rm -rf /var/lib/apt/lists/*
