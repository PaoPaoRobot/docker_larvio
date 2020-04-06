docker run -itd -v /YOUR_PATH/Dataset/EuRoC:/root/Dataset:ro -p 5900:5900 larvio_vnc_bionic

docker cp /YOUR_PATH/LARVIO `docker ps | grep larvio_vnc_bionic | awk '{print $1}'`:/root/LARVIO

docker exec -it `docker ps | grep larvio_vnc_bionic | awk '{print $1}'` /bin/bash -c \
    '. /opt/ros/melodic/setup.bash && cd /root/LARVIO/ros_wrapper && catkin_make'

docker exec -itd `docker ps | grep larvio_vnc_bionic | awk '{print $1}'` /bin/bash -c \
    'cd /root/LARVIO/ros_wrapper && . devel/setup.bash && roslaunch larvio larvio_euroc.launch'

sleep 3

docker exec -it `docker ps | grep larvio_vnc_bionic | awk '{print $1}'` /bin/bash -c \
    '. /opt/ros/melodic/setup.bash && rosbag play /root/Dataset/bag/MH_01_easy.bag'