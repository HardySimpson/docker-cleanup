# docker cleanup

a tiny all in one shell, which removes:

- containers that not running more than 1 Day ago
- images that don't belong to any remaining container(so keep the image cache since 1 Day runned)

intend to run as crontab job

## feature

- it will remove all `<none>:<none>` image
- if the image has multiple repo:tag reference it, it will remove all repo:tag except with running container. Actually it is a nature of "docker rmi"
- few error messages will be show on screen, you can decide 2>/dev/null or not
- learn many thing from docker-rc, but I feel it could impelment more lightly

### have fun!

---

# docker cleanup

这是一个简单的docker清理脚本，会删除:

- 停止超过1天的容器
- 1天之内没有运行容器的镜像

## 特性
- 会删除`<none>:<none>`的镜像
- 如果这个镜像有多个repo:tag指向，会删除多余的repo:tag，除了正在跑的容器对应的repo:tag，实际上这是docker rmi的特性
- 少量报错信息，你可以决定要不要2>/dev/null来不显示这些信息
- 从docker-rc学到了不少，就是觉得可以写的更精简一些

### 玩的开心!
