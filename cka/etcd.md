# Clusters with external etcd

https://github.com/kodekloudhub/community-faq/blob/main/docs/etcd-faq.md

This covers both kubeadm clusters where etcd is not running as a pod, and fully manual installations like kubernetes the hard way.

Some people have suggested that this is how the exam is set up, as in you have to do it all from the exam node and not the control node for the target cluster. It requires a bit more work!

On the node where you are instructed to do the task, first determine how many etcd processes there are

sudo ps -x | grep bin/etcd
If there's more than one, you need to identify the correct one! In the output of the above command, you should be able to see the --listen-client-urls argument. Note down the port numbers from this URL for each. In the exam, use the mousepad application to take notes.

Go onto the control node for the target cluster and run

If it is a kubeadm cluster (api server is running as a pod)

grep etcd-servers /etc/kubernetes/manifests/kube-apiserver.yaml
If it is not kubeadm, and api server is an operating system service

sudo ps -x | grep apiserver
Find --etcd-servers in the argument list and note the port number. You need to match that with one of the port numbers you've noted down. That will get you the correct etcd process.

Log out of the control node and return to the node running etcd.

Next, find the unit file for the correct etcd service. The following will give you the file names.

systemctl list-unit-files | grep etcd
Output

etcd-1.service                               enabled         enabled
etcd-2.service                               enabled         enabled
To locate these files, run the following on each filename returned by the command above

sytemctl cat XXXX.service
...where XXXX.service is e.g. etcd-1.service. This will show the file content with a comment above it which is the location of the unit file.

Output

# /etc/systemd/system/etcd-1.service
[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
ExecStart=/usr/local/bin/etcd \
--- truncated---
  --listen-client-urls https://192.168.56.11:2379,https://127.0.0.1:2379
--- truncated---
  --data-dir /var/lib/etcd
Find the correct one by examining each identified unit file and choose the one that has the matching port number for the --listen-client-urls argument. You will need to edit this later.

Now do the backup and specify --endpoint CLIENT_URL where CLIENT_URL is the URL from the --listen-client-urls in the identified unit file. If --listen-client-urls includes https://127.0.0.1:2379 and you are on the node where etcd is running, then you do not require --endpoints

Next do the restore using whatever backup file you are instructed to use.

Finally edit the identified unit file

Change the --data-dir argument to point to the new directory (e.g /var/lib/etcd-from-backup)

Note when editing in the service unit file whether a specific user account is being used to run etcd. If it is, you need to set the owner of the restored directory structure to this user with chown -R

Restart the service

sudo systemctl daemon-reload
sudo systemctl restart XXXX.service
where XXXX.service is the filename (not path) of the service unit file you have edited. Note that a daemon-reload is always necessary after editing a unit file.

Please also try the following lab for practice of external etcd

https://kodekloud.com/topic/practice-test-backup-and-restore-methods-2-2/