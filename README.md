
# What is this?
Simple Linux(🐧) server alerting, which sends push notifications to your devices 📱💻

There are three parts to this script:
- 👨‍⚕️Health Alerts (CPU,RAM,DISK)
- 📂 File Integrity (/etc/passwd /etc/shadow)
- 🗝️ SSH Alert (PAM.D Integration)

Screenshots:
TBA


---

## Prerequisites
- Requires to run as root user (Monitors critical files)
- Install bc at packages (apt-get install bc at)
- Install NTFY (https://github.com/dschep/ntfy)

> sudo pip install ntfy[emoji]

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

> su root

> cd /opt

> git clone https://github.com/chasgames/EZ-Server-Alerting

> crontab -e

> */10 * * * * /opt/EZ-Server-Alerting/health_scan.sh >/dev/null 2>&1


For SSH Alerts we directly want to implement with PAM.d

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
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 99.83    0.040349         672        60        23 wait4
  0.10    0.000042           0       226        41 stat
  0.03    0.000014           0       239           fstat
  0.03    0.000014           0        29        29 ioctl
  0.00    0.000000           0       260           read
  0.00    0.000000           0        31           write
  0.00    0.000000           0       232        36 open
  0.00    0.000000           0       362        26 close
  0.00    0.000000           0        19         5 lseek
  0.00    0.000000           0       386           mmap
  0.00    0.000000           0       247           mprotect
  0.00    0.000000           0        21           munmap
  0.00    0.000000           0       108           brk
  0.00    0.000000           0       411           rt_sigaction
  0.00    0.000000           0       315           rt_sigprocmask
  0.00    0.000000           0        23           rt_sigreturn
  0.00    0.000000           0       224       150 access
  0.00    0.000000           0        25           pipe
  0.00    0.000000           0        52           dup2
  0.00    0.000000           0        12           getpid
  0.00    0.000000           0        39           clone
  0.00    0.000000           0        20           execve
  0.00    0.000000           0         5           uname
  0.00    0.000000           0        10         4 fcntl
  0.00    0.000000           0         2           chdir
  0.00    0.000000           0         9           getrlimit
  0.00    0.000000           0         3           sysinfo
  0.00    0.000000           0        92           getuid
  0.00    0.000000           0        92           getgid
  0.00    0.000000           0        92           geteuid
  0.00    0.000000           0        92           getegid
  0.00    0.000000           0        12           getppid
  0.00    0.000000           0        12           getpgrp
  0.00    0.000000           0        18           getgroups
  0.00    0.000000           0         9           sigaltstack
  0.00    0.000000           0        27         2 statfs
  0.00    0.000000           0        20           arch_prctl
  0.00    0.000000           0         1           futex
  0.00    0.000000           0         2           set_tid_address
  0.00    0.000000           0         3         2 fadvise64
  0.00    0.000000           0         2           set_robust_list
------ ----------- ----------- --------- --------- ----------------
100.00    0.040419                  3844       318 total

```

To debug the errors
strace -o strace.out -f ./health_scan.sh

To debug cronjob not working
> */10 * * * * /opt/EZ-Server-Alerting/health_scan.sh >> /opt/EZ-Server-Alerting/error.log 2>&1
