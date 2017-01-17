import common
import edify_generator

def RemoveDeviceAssert(info):
  edify = info.script
  for i in xrange(len(edify.script)):
    if "ro.product" in edify.script[i]:
      edify.script[i] = """getprop("ro.product.device") == "XT1514" || getprop("ro.build.product") == "XT1514" || getprop("ro.product.device") == "XT1521" || getprop("ro.build.product") == "XT1521" || getprop("ro.product.device") == "XT1524" || getprop("ro.build.product") == "XT1524" || getprop("ro.product.device") == "XT1526" || getprop("ro.build.product") == "XT1526" || getprop("ro.product.device") == "XT1527" || getprop("ro.build.product") == "XT1527" || getprop("ro.product.device") == "XT1523" || getprop("ro.build.product") == "XT1523" || getprop("ro.product.device") == "surnia_uds" || getprop("ro.build.product") == "surnia_uds" || getprop("ro.product.device") == "surnia_umts" || getprop("ro.build.product") == "surnia_umts" || getprop("ro.product.device") == "surnia" || getprop("ro.build.product") == "surnia" || getprop("ro.product.device") == "surnia_udstv" || getprop("ro.build.product") == "surnia_udstv" || abort("This package is for device: XT1514,XT1521,XT1524,XT1526,XT1527,XT1523,surnia_uds,surnia_umts,surnia,surnia_udstv; this device is " + getprop("ro.product.device") + ".");
if getprop("ro.boot.carrier") == "sprint" && getprop("ro.boot.fsg-id") == "" then
ui_print("Sprint CDMA variant detected!");
ui_print("Reboot into Bootloader Mode, connect your device to PC and from PC terminal type:");
ui_print("fastboot oem config fsg-id boost    if you are a Boost Mobile user");
ui_print("fastboot oem config fsg-id frdm     if you are a FreedomPop user");
ui_print("fastboot oem config fsg-id ringplus if you are a RingPlus user");
ui_print("fastboot oem config fsg-id sprint   if you are a Sprint user or not listed");
ui_print("fastboot oem config fsg-id virgin   if you are a Virgin Mobile user");
ui_print("and then flash MIUI 8 again");
abort("**********");
endif;
unmount("/data");
unmount("/system");"""
      return

def AddAssertions(info):
   edify = info.script
   for i in xrange(len(edify.script)):
    if " ||" in edify.script[i] and ("ro.product.device" in edify.script[i] or "ro.build.product" in edify.script[i]):
      edify.script[i] = edify.script[i].replace(" ||", ' ')
      return

def AddArgsForFormatSystem(info):
  edify = info.script
  for i in xrange(len(edify.script)):
    if "format(" in edify.script[i] and "/dev/block/platform/soc.0/by-name/system" in edify.script[i]:
      edify.script[i] = 'format("ext4", "EMMC", "/dev/block/platform/soc.0/by-name/system", "0", "/system");'
      return

def WritePolicyConfig(info):
  try:
    file_contexts = info.input_zip.read("META/file_contexts")
    common.ZipWriteStr(info.output_zip, "file_contexts", file_contexts)
  except KeyError:
    print "warning: file_context missing from target;"

def FullOTA_InstallEnd(info):
    WritePolicyConfig(info)
    RemoveDeviceAssert(info)

def IncrementalOTA_InstallEnd(info):
    RemoveDeviceAssert(info)
