# LARVIO镜像
基于ros:melodic-perception开发。提供LARVIO运行环境和源码，所有例程都已编译好。提供了VNC可视化。

## 使用说明
### 获得镜像
首先从DockerHub拉取镜像：
```
docker pull paopaorobot/larvio
```
或利用Dockerfile进行本地构建：
```
git clone https://github.com/PaoPaoRobot/docker_larvio.git
cd ./docker_larvio
docker build -t paopaorobot/larvio .
```
### VNC可视化准备
下载与你电脑操作系统匹配的[VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/)。
### 下载数据集
LARVIO的例程提供了[EuRoC](https://projects.asl.ethz.ch/datasets/doku.php?id=kmavvisualinertialdatasets)数据集的演示程序。其中pangolin例程需求asl格式，ros nodelet例程需求bag格式，如果网速比较慢，建议下载最小的V102序列。
### 创建container
我们假设你将V1_02的asl和bag分别存放在宿主的YOUR_PATH_TO_EUROC/V1_02_medium路径下，执行下述命令实例化container：
```
docker run -itd -v YOUR_PATH_TO_EUROC/V1_02_medium:/root/Dataset/V1_02 -p 5900:5900 paopaorobot/larvio
```
然后打开VNC Viewer，输入127.0.0.1:5900进行连接。
### Pangolin例程
在VNC Viewer中，打开一个终端，执行下述命令：
```
cd /root/LARVIO/build
./larvio /root/Dataset/V1_02/mav0/imu0/data.csv /root/Dataset/V1_02/mav0/cam0/data.csv /root/Dataset/V1_02/mav0/cam0/data ../config/euroc.yaml
```
### ROS例程
在宿主机终端中，执行下述命令打开LARVIO节点：
```
docker exec -itd `docker ps | grep paopaorobot/larvio | awk '{print $1}'` /bin/bash -c 'cd /root/LARVIO/ros_wrapper && . devel/setup.bash && roslaunch larvio larvio_euroc.launch'
```
然后在VNC Viewer中，打开一个终端，执行下述命令打开rviz：
```
cd /root/LARVIO/ros_wrapper
. devel/setup.bash
roslaunch larvio larvio_rviz.launch
```
回到宿主机终端，执行下命令播放数据集：
```
docker exec -it `docker ps | grep paopaorobot/larvio | awk '{print $1}'` /bin/bash -c '. /opt/ros/melodic/setup.bash && rosbag play /root/Dataset/V1_02/V1_02_medium.bag'
```
