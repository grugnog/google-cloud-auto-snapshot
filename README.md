
# Automatic Snapshots for Google Compute Engine

This is a background bash script to automatically snapshot all Google Compute Engine disks in a Google cloud project.

Google snapshots are incremental, and don't need to be deleted. If you delete an earlier snapshot the block are automatically migrated to the jater snapshot.  So deleting snapshots does not save space, but for convenience, rather than an infinitely long list, it is useful to purge earlier snapshots assuming that you would never need granularity. This script assumes 60 days is sufficient.

Much of the inspiration for this script came from http://stackoverflow.com/questions/27418427/how-to-create-and-rotate-automatic-snapshot
and much of the installation instructions from here https://github.com/jacksegal/google-compute-snapshot


## How it works
google-cloud-auto-snapshot.sh will:

- Determine all Compute Engine Disks in the current project, regardless of
- Take a snapshot of all disks - snapshots prefixed autogcs-{DISK_NAME-YYYY-MM-DD-sssssssss}
- The script will then delete all associated snapshots taken by the script that are older than 60 days


## Prerequisites

* the gcloud SDK must be install which includes the gcloud cli [https://cloud.google.com/sdk/downloads](https://cloud.google.com/sdk/downloads)
* the gcloud project must be set to the project that owns the disks

## Installation

Install the script on any single server ( it will back up ALL disks in a project regardless of the server), the script doesn't even have to run on Google Compute Engine instance, any linux machine will work.

**Install Script**: Download the latest version of the snapshot script and make it executable, e.g. ```
cd ~
wget https://gitlab.com/alan8/google-cloud-auto-snapshot/raw/master/google-cloud-auto-snapshot.sh
chmod +x google-cloud-auto-snapshot.sh
sudo mkdir -p /opt/google-cloud-auto-snapshot
sudo mv google-cloud-auto-snapshot.sh /opt/google-cloud-auto-snapshot/
```


**Setup CRON**: You should then setup a cron job in order to schedule a snapshot as often as you like, e.g. for daily cron:
```
0 5 * * * root /opt/google-cloud-auto-snapshot/google-cloud-auto-snapshot.sh >> /var/log/cron/snapshot.log 2>&1
```

**Manage CRON Output**: Ideally you should then create a directory for all cron outputs and add it to logrotate:

- Create new directory:
``` 
sudo mkdir /var/log/cron
```
- Create empty file for snapshot log:
```
sudo touch /var/log/cron/snapshot.log
```
- Change permissions on file:
```
sudo chgrp adm /var/log/cron/snapshot.log
sudo chmod 664 /var/log/cron/snapshot.log
```
- Create new entry in logrotate so cron files don't get too big :
```
sudo nano /etc/logrotate.d/cron
```
- Add the following text to the above file:
```
/var/log/cron/*.log {
    daily
    missingok
    rotate 14
    compress
    notifempty
    create 664 root adm
    sharedscripts
}
```

**To manually test the script:**
```
sudo /opt/google-cloud-auto-snapshot/google-cloud-auto-snapshot.sh
```

## Snapshot Retention

Snapshots are kept for 60 days

## Limitations, possible future enhancements
* Works for all disks in a project, can't be selective
* Only works for default project for the gcloud environment ( see  gcloud info )
* Only manages snapshots created by the script ( prefixed autogcs- )
