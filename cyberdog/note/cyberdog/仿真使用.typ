= 仿真使用
此文档记录张子鉴，杨佳鸣同学的部分工作

*注意：请先关闭conda，退出conda环境，不然可能会有意想不到的错误！！！*
+ 安装docker,ros galactic

 https://docs.docker.com/engine/install/ubuntu/

 https://docs.ros.org/en/galactic/Installation/Ubuntu-Install-Debians.html

+ 下载比赛压缩包

 https://pan.educg.net/s/L5myHM


+ 本地导入 Docker 镜像（注意这只加载了镜像，但没有运行容器）

 sudo docker load -i cyberdog_raceV2.tar

+ 运行 Docker 镜像来创建一个容器

 sudo docker run -it --privileged=true -e DISPLAY=\$DISPLAY -v/tmp/.X11-unix:/tmp/.X11-unix cyberdog_sim:v2

+ 首先我们要把这个比赛docker展开，方便修改代码
 - sudo docker ps -a用来显示所有容器的信息

 #image("pictures/1.png")

+ 使用docker cp将目录复制到本地

 - docker cp 2096cacd4316:/home/cyberdog_sim ~/projects/sim

 /home/cyberdog_sim是容器的源目录，~/projects/sim是本地目录
 但是文件会有锁，无法更改文件，需要更改文件权限方便后续操作

 - sudo chown -R username filename

 username就是你Ubuntu系统安装的时候取得名字，filename就是被锁文件夹名字。

 例如 sudo chown -R coco libbpf 这个时候libbpf文件夹就被解锁而且里面的内容都不会被锁，也就是相当于是全部解锁。
+ 进入~/projects/sim/cyberdog_sim文件夹，阅读REDAME.md,安装依赖
 #image("pictures/2.png")

 注意安装lcm的时候可能报错
 #image("pictures/3.png")
 可以不用管，直接make就行

+ 仿真使用

  详见https://miroboticslab.github.io/blogs/#/cn/cyberdog_gazebo_cn
 
  *注意编译的时候要把build,intall,log这三个文件夹删掉再编译。*
  #image("pictures/13.png")
  

  `
  ## 下载
  $ git clone https://github.com/MiRoboticsLab/cyberdog_sim.git
  因为我们是从比赛压缩包下载的，里面有这个cyberdog_sim，应该就不用再git了，直接vcs展开即可
  $ cd cyberdog_sim
  $ vcs import < cyberdog_sim.repos

  ## 编译
  需要将src/cyberdog locomotion/CMakeLists.txt中的BUILD_ROS置为ON
  需要在cyberdog_sim文件夹下进行编译

  $ source /opt/ros/galactic/setup.bash 
  $ colcon build --merge-install --symlink-install --packages-up-to cyberdog_locomotion cyberdog_simulator


  ## 使用
  需要在cyberdog_sim文件夹下运行

  $ python3 src/cyberdog_simulator/cyberdog_gazebo/script/launchsim.py

  `
  编译的时候可能会出现这个stderr，不用管
  #image("pictures/6.png")
  此时应该会弹出来几个控制台和GUI界面，但是此时比赛场景加载不出来
  #image("pictures/4.png")
  #image("pictures/5.png")

  接着见官方文档的2.2.4仿真例程

  在仿真程序中提供了cyberdog_example的仿真例程包，该包提供了keybroad_commander和cyberdogmsg_sender两个例程。 keybroad_commander演示了如何使用gampad_lcmt向控制发送基本控制指令 该程序运行方法如下： 需要在cyberdog_sim文件夹下运行

  `
  $ source /opt/ros/galactic/setup.bash
  $ source install/setup.bash
  $ ./build/cyberdog_example/keybroad_commander
  `
  运行后，可在终端输入对应的指令来控制机器人 
  `
  键位 	指令 	键位 	指令
  w 	x方向速度增加最大速度的0.1倍 	i 	pitch方向速度增加最大速度的0.1倍
  s 	x方向速度减少最大速度的0.1倍 	k 	pitch方向速度减少最大速度的0.1倍
  d 	y方向速度增加最大速度的0.1倍 	l 	yaw方向速度增加最大速度的0.1倍
  a 	y方向速度减少最大速度的0.1倍 	j 	yaw方向速度减少最大速度的0.1倍
  e 	切换为QP站立模式(kp kd较小) 	t 	切换为缓慢趴下模式
  r 	切换为locomotion模式 	y 	切换为恢复站立模式
  `

  输入r，进入键盘控制，输入w，狗向前移动，输入y，狗恢复站立。
  #image("pictures/7.png")
  cyberdogmsg_sender演示了使用/yaml_parameter来对yaml文件中的控制参数进行实时修改，以及使用/apply_force来仿真中的机器人施加外力。 该程序的运行方法如下： 需要在cyberdog_sim文件夹下运行


  `
  $ source /opt/ros/galactic/setup.bash
  $ source install/setup.bash
  $ ./build/cyberdog_example/cyberdogmsg_sender
  `
  该例程先把参数use_rc置为0(该参数为1时为遥控模式，置为0后才能够通过仿真程序进行控制)；
  然后通过设置control_mode参数使机器人站立起来，并进入locomotion模式，即原地踏步(control_mode的参数可参阅控制程序的control_flag.h文件)；
  接着对机器人的左前小腿施加侧向的外力； 最后通过修改des_roll_pitch_height参数使机器人在踏步时roll角变为0.2弧度。

+ 其他例程

  https://miroboticslab.github.io/blogs/#/cn/cyberdog_loco_cn?id=_24-%e6%8e%a5%e5%8f%a3%e7%a4%ba%e4%be%8b
  + 基本动作

    在cyberdog_sim/src/loco_hl_example/basic_motion中运行main.py,控制机 器人依次完成站立，握手，作揖，抬头，低头，原地踏步旋转，趴下等动作。
    
    注意：依赖lcm数据类型文件robot_control_cmd_lcmt.py和robot_control_response_lcmt.py。
    #image("pictures/8.png")

  + 序列动作

    在cyberdog_sim/src/loco_hl_example/sequential_motion内
    实现控制机器人依次站立，调整高度，抬起右后腿，原地踏步旋转，趴下等动作

    注意：运行该Python脚本，依赖lcm数据类型文件robot_control_cmd_lcmt.py和序列动作文件cyberdog2_ctrl.toml。
    #image("pictures/9.png")

  + 自定义步态

    在cyberdog_sim/src/loco_hl_example/customized_gait文件夹中运行main.py.

    本例程是Python脚本，通过读取自定义步态文件和序列动作文件，实现控制机器人依次站立，太空步和趴下等动作。示例中Gait_Params_moonwalk.toml 文件包含2.2.2自定义步态相关参数介绍，脚本首先按一定映射关系将其编码为基本robot_control_cmd_lcmt 结构体序列(Gait_Params_moonwalk_full.toml)再下发。

    注意：运行该Python脚本，依赖lcm数据类型文件robot_control_cmd_lcmt.py和file_send_lcmt.py，自定义步态文件Gait_Def_moonwalk.toml和Gait_Params_moonwalk.toml，以及序列动作文件Usergait_List.toml。

+ 解决打开时赛道环境不显示的问题

  在cyberdog_sim/src/cyberdog_simulator/cyberdog_gazebo/world文件夹中，用vscode打开
  - `code .`
  然后`ctrl+F`搜索`/home`
  因为`/home`是docker容器里面的路径，这里我们要将他改为自己电脑里面的路径。
  在cyberdog_sim/src/cyberdog_simulator/cyberdog_gazebo/world文件夹中，输入pwd显示当前路径，复制cyberdog_sim前面的路径然后替换掉`/home`即可(一定要是绝对路径，不能是相对路径)
  #image("pictures/15.png")
  #image("pictures/16.png")
  再打开仿真，赛道就出现了（此时箭头，二维码仍没有）。
  #image("pictures/17.png")

+ 解决箭头、二维码不显示的问题

  压缩包里面有箭头、二维码的png图片，以及一个gazebo.material。
  因为这些文件不在cyberdogsim文件夹里，所以提取出来没有。

  gazebo安装路径一般是：`/usr/share/gazebo-11`

  在`/usr/share/gazebo-11/media/materials/scripts`里面替换掉gazebo.material同名文件，二维码，箭头图片在放进`/usr/share/gazebo-11/media/materials/textures`里。

  让`/usr/share/gazebo-11`获得写权限
  - `sudo chmod 777 /usr/share/gazebo-11`
  然后打开仿真，发现有箭头，二维码了
  #image("pictures/18.png")


