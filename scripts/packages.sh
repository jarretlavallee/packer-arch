#!/usr/bin/bash -x

# Clean the pacman cache.
/usr/bin/yes | /usr/bin/pacman -S puppet cloud-init
/usr/bin/rm -f /etc/cloud/cloud.cfg.d/*
/usr/bin/sed -i 's/ubuntu/arch/g' /etc/cloud/cloud.cfg
/usr/bin/echo 'datasource_list: [ NoCloud, ConfigDrive, OpenNebula, Azure, AltCloud, OVF, MAAS, GCE, OpenStack, CloudSigma, Ec2, CloudStack, None ]' >> /etc/cloud/cloud.cfg
sed -i 's/util.write_file(out_fn, conf, 0o644)/util.write_file(out_fn, str(conf), 0o644)/' /usr/lib/python2.7/site-packages/cloudinit/distros/arch.py
/usr/bin/systemctl enable cloud-init.service
