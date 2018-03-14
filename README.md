
What is this?
Simple linux server alerting, which sends push notifications to your device.

Prerequisites
- apt-get install bc

How do I use this?

Install NTFY (https://github.com/dschep/ntfy)

```sudo pip install ntfy```

Edit/Create the file /root/.config/ntfy/ntfy.yml
Add your backend service as according to NTFY documentation. For example, for pushover. we would put:

ntfy.yml
```
backends:
    - pushover
pushover:
    user_key: pastethekeyherefrompushover
```

Confirm NTFY works by typing:
```
ntfy send "test"
```

You should recieve the push notification to your device if setup correctly.

