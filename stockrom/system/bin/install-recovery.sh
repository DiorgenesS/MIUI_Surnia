#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 9185280 c850ebda64512bd50b2ae8d6314d2dbba6c21973 6717440 493141504c38cd2e1c643fe3407885ebb414c16a
fi

if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:9185280:c850ebda64512bd50b2ae8d6314d2dbba6c21973; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:6717440:493141504c38cd2e1c643fe3407885ebb414c16a EMMC:/dev/block/bootdevice/by-name/recovery c850ebda64512bd50b2ae8d6314d2dbba6c21973 9185280 493141504c38cd2e1c643fe3407885ebb414c16a:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
