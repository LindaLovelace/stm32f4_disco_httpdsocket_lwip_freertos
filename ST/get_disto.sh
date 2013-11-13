#!/bin/sh

URL="http://www.element14.com/community/servlet/JiveServlet/downloadBody/54872-102-2-274638/STM32F4DIS-BB%20Discover%20More%20Software%20Examples.zip"
DSTDIR="STM32F4xx_Ethernet_Example"

if [ ! -d ${DSTDIR} ]; then
	wget -c ${URL} -O foo.zip
	unzip foo.zip -d tmp
	mv tmp/STM32F4DIS*/STM32F4xx_Et* ${DSTDIR} 
	rm -rf tmp *.zip
else
	echo "Directory ${DSTDIR} already exists. Aborting."
fi

