
# What is this?
Simple Linux(🐧) server alerting⏰, which sends push notifications to your devices 📱💻

There are three parts to this script:
- 👨‍⚕️Health Alerts (CPU,RAM,DISK)
- 📂 File Integrity (/etc/passwd)
- 🗝️ SSH Alert (PAM.D Integration)


---

## Prerequisites
- Install bc at (apt-get install bc at)
- Install NTFY (https://github.com/dschep/ntfy)

> sudo pip install ntfy

Edit/Create the file /root/.config/ntfy/ntfy.yml
See NTFY documentation. For example, for pushover. we would put:

ntfy.yml
```
backends:
    - pushover
pushover:
    user_key: pastethekeyherefrompushover
```

Confirm NTFY works by typing:

> ntfy send "test"


You should recieve the push notification to your device if setup correctly.


---

## How do I use this?

### Part 1 - Health Cronjob

> su root

> cd /opt

> git clone https://github.com/chasgames/EZ-Server-Alerting

> crontab -e

> */10 * * * * /opt/EZ-Server-Alerting/health_scan.sh >/dev/null 2>&1

### Part 2 - File Integrity Cronjob

TBA

### Part 3 - SSH Alert

TBA






---

## What else?

Regular performance of the script looks to be good.
```
time ./health_scan.sh

real    0m0.039s
user    0m0.004s
sys     0m0.000s
```

strace -c ./health_scan.sh

```
strace -c ./health_scan.sh
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
  0.00    0.000000           0        21           read
  0.00    0.000000           0        14           open
  0.00    0.000000           0        34         6 close
  0.00    0.000000           0        41        18 stat
  0.00    0.000000           0        13           fstat
  0.00    0.000000           0         4           lseek
  0.00    0.000000           0        14           mmap
  0.00    0.000000           0         8           mprotect
  0.00    0.000000           0         1           munmap
  0.00    0.000000           0        19           brk
  0.00    0.000000           0        22           rt_sigaction
  0.00    0.000000           0        56           rt_sigprocmask
  0.00    0.000000           0         5           rt_sigreturn
  0.00    0.000000           0         1         1 ioctl
  0.00    0.000000           0        17        11 access
  0.00    0.000000           0         7           pipe
  0.00    0.000000           0         1           dup2
  0.00    0.000000           0         1           getpid
  0.00    0.000000           0         8           clone
  0.00    0.000000           0         1           execve
  0.00    0.000000           0        13         5 wait4
  0.00    0.000000           0         1           uname
  0.00    0.000000           0         3         1 fcntl
  0.00    0.000000           0         2           getrlimit
  0.00    0.000000           0         1           sysinfo
  0.00    0.000000           0        13           getuid
  0.00    0.000000           0        13           getgid
  0.00    0.000000           0        13           geteuid
  0.00    0.000000           0        13           getegid
  0.00    0.000000           0         1           getppid
  0.00    0.000000           0         1           getpgrp
  0.00    0.000000           0         1           arch_prctl
------ ----------- ----------- --------- --------- ----------------
100.00    0.000000                   363        42 total
```

To debug the errors
strace -o strace.out -f ./health_scan.sh

To debug cronjob not working
> */10 * * * * /opt/EZ-Server-Alerting/health_scan.sh >> /opt/EZ-Server-Alerting/error.log 2>&1
