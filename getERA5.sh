#!/bin/bash -l
#path donde esta el codigo y donde guardar los datos que se descargaran
CODEDIR=/Path/donde/tenemos/este/script
DATADIR=/Path/donde/se/descargaran/los/datos
# es necesario instalar otros paquetes como grib 
# exportamos anaconda3, por lo que debemos excribir su path y el comando bin:$PATH como se muestra a continuacion:
export PATH=/home/jessica/anaconda3/bin:$PATH
source activate root
cd $CODEDIR
#Debemos escribir las fechas y las coordenadas del area a descargar
DATE1=20170806 #año mes dia
DATE2=20170810 #año mes dia
Nort=-17 
West=-79
Sout=-53
East=-60
YY1=`echo $DATE1 | cut -c1-4`
MM1=`echo $DATE1 | cut -c5-6`
DD1=`echo $DATE1 | cut -c7-8`
YY2=`echo $DATE2 | cut -c1-4`
MM2=`echo $DATE2 | cut -c5-6`
DD2=`echo $DATE2 | cut -c7-8`
sed -e "s/DATE1/${DATE1}/g;s/DATE2/${DATE2}/g;s/Nort/${Nort}/g;s/West/${West}/g;s/Sout/${Sout}/g;s/East/${East}/g;" GetERA5-sfc.py > GetERA5-${DATE1}-${DATE2}-sfc.py
python GetERA5-${DATE1}-${DATE2}-sfc.py
sed -e "s/DATE1/${DATE1}/g;s/DATE2/${DATE2}/g;s/Nort/${Nort}/g;s/West/${West}/g;s/Sout/${Sout}/g;s/East/${East}/g;" GetERA5-ml.py > GetERA5-${DATE1}-${DATE2}-ml.py
python GetERA5-${DATE1}-${DATE2}-ml.py
mkdir -p ${DATADIR}/$YY1
mv ERA5-${DATE1}-${DATE2}-sfc.grb ERA5-${DATE1}-${DATE2}-ml.grb ${DATADIR}/$YY1/
cd ${DATADIR}/$YY1/
echo 'write "[centre]_[dataDate]_[dataType]_[levelType]_[step].grib[edition]";' > split.rule
grib_filter split.rule ERA5-${DATE1}-${DATE2}-sfc.grb
grib_set -s deletePV=1,edition=1 ERA5-${DATE1}-${DATE2}-ml.grb ERA5-${DATE1}-${DATE2}-ml.grib1
grib_filter split.rule ERA5-${DATE1}-${DATE2}-ml.grib1
# If you want to delete original files, you can uncomment the following line.
# rm *grb
exit 0
