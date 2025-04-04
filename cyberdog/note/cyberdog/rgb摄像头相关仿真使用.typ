= rgb摄像头相关仿真使用
日期3.16
// 文档记录张子鉴，杨佳鸣同学的工作，记录者卢可
== 在仿真平台中添加image订阅

打开ros
source /opt/ros/galactic/setup.bash 
在cyberdog_sim/src/cyberdog_simulator/cyberdog_robot/cyberdog_description/xacro文件夹里修改gazebo.xacro，添加

`
  <gazebo reference="RGB_camera_link">
      <sensor type="camera" name="rgb camera">
          <always_on>true</always_on>
          <update_rate>15.0</update_rate>
          <camera name="rgb_camera">
              <horizontal_fov>1.46608</horizontal_fov>
              <image>
                  <width>320</width>
                  <height>180</height>
                  <format>R8G8B8</format>
              </image>
              <distortion>
                  <k1>0.0</k1>
                  <k2>0.0</k2>
                  <k3>0.0</k3>
                  <p1>0.0</p1>
                  <p2>0.0</p2>
                  <center>0.5 0.5</center>
              </distortion>
          </camera>
          <plugin name="rgb_camera_plugin"
          filename="libgazebo_ros_camera.so">
              <ros>
                  <!-- <namespace>stereo</namespace> -->
                  <remapping>~/image_raw:=image_raw</remapping>
                  <remapping>~/camera_info:=camera_info</remapping>
              </ros>
              <!-- Set camera name. If empty, defaults to sensor
              name (i.e. "sensor_name") -->
              <camera_name>rgb_camera</camera_name>
              <!-- Set TF frame name. If empty, defaults to link
              name (i.e. "link_name") -->
              <frame_name>RGB_camera_link</frame_name><hack_baseline>0.2</hack_baseline>
          </plugin>
      </sensor>
  </gazebo>
`

然后运行仿真程序，运行仿真程序后可通过 window->Topic Visualization 中找到对应 topic 并打开,可确认rgb 相机正常运行
#image("pictures/10.png")
#image("pictures/11.png")
通过 ros2 topic list可确认 topic 正常发送
#image("pictures/12.png")


== 在仿真平台中打开摄像头
先添加订阅image

装一个包

`sudo apt install ros-galactic-gazebo-ros-pkgs`

检查是否安装成功，在/opt/ros/galactic/lib中寻找libgazebo_ros_camera.so

`
find /path/to/folder -name "filename" 
or 
ls /path/to/folder | grep "filename"
`然后在重新编译src就可以看到摄像头了

ros2 topic list

要有rgb carema/下面的四个话题有启动成功了

然后可视化

