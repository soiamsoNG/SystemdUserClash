# SystemdUserClash

使用 systemctl --user,  控制Clash

## 安装

复制到 $HOME


在 $HOME/.config/clash/subscribe_url.txt 中配置订阅地址

```bash
SUBSCRIBE="https://www.example.com/api/v1/client/subscribe?token=example&flag=clash"
```

## 启动服务
``` console
foo@bar:~$ systemctl --user daemon-reload
foo@bar:~$ systemctl --user enable clash.service --now
foo@bar:~$ systemctl --user enable clash_subscribe.timer --now
foo@bar:~$ systemctl --user enable clash_resume.service --now
```

| 文件 | 功能 |
| :-----| :---- |
| clash.service | 控制$HOME/bin/clash-linux-amd64运行 |
| clash_subscribe.timer | 控制$HOME/bin/clash-subscribe.sh周期性运行 |
| clash_resume.service | 控制$HOME/bin/clash-resume.sh运行 |
| $HOME/bin/clash-resume.sh | 获得唤醒信号后重启clash.service
| $HOME/bin/calsh-subscribe.sh | 更新 clash 的 config.yaml
