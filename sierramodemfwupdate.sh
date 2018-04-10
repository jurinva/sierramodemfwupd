#!/bin/bash
cwe=SWI9X30C_02.24.05.06.cwe
nvu=SWI9X30C_02.24.05.06_VERIZON_002.034_000.nvu

echo "a) Set firmware preference setting:"
sudo qmicli -d /dev/cdc-wdm0 --dms-set-firmware-preference="02.24.05.06,002.034_000,VERIZON"

echo "b) Request power cycle:"
sudo qmicli -d /dev/cdc-wdm0 --dms-set-operating-mode=offline
sudo qmicli -d /dev/cdc-wdm0 --dms-set-operating-mode=reset

echo "c) Wait for the /dev/ttyUSB device to appear."
sleep 30s

echo "d) Run updater operation while in QDL download mode:"
#help of qmi-firmware-update tell to us that we must use --update-qdl but it does not work
#sudo qmi-firmware-update -t /dev/ttyUSBX --update-qdl SWI9X30C_02.24.05.06.cwe SWI9X30C_02.24.05.06_VERIZON_002.034_000.nvu
#next string is working
sudo qmi-firmware-update -v -s 002:052 --device-open-auto --update $cwe $nvu
