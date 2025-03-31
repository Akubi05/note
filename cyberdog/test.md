# github配置ssh key
## 日期：2025.3.12

+ 问题： 在使用如下命令vcs import . < cyberdog.repos展开仓库时，报错luke@Akubi:~/projects/cyberdog_ws$ vcs import . < cyberdog.repos
At least one hostname (github.com) is unknown, switching to a single worker to allow interactively answering the ssh question to confirm the fingerprint
The authenticity of host 'github.com (20.205.243.166)' can't be established.
ECDSA key fingerprint is SHA256:p2QAMXNIC1TJYWeIOttrVc98/R1BUFWu3/LiyKgUfQM.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
EEEEEEEEE
=== ./bridges (git) ===
Could not determine ref type of version: Warning: Permanently added 'github.com,20.205.243.166' (ECDSA) to the list of known hosts.
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.
Please make sure you have the correct access rights
and the repository exists.
=== ./cyberdog_nav2 (git) ===
Could not determine ref type of version: git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.
。。。
Please make sure you have the correct access rights
and the repository exists.

原因：github未配置ssh key

解决办法：参考帖子https://blog.csdn.net/weixin_42310154/article/details/118340458
官方文档
https://docs.github.com/zh/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys
等一系列文档