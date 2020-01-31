#!/bin/bash -l
#path de donde tenemos este script y de donde estan los datos
CODEDIR=/Path/donde/tenemos/este/script
DATADIR=/Path/donde/estan/los/datos/descargados
# exportamos anaconda, por lo que debemos excribir su path y el comando bin:$PATH como se muestra a continuacion:
export PATH=/home/jessica/anaconda3/bin:$PATH
source activate root
cd $CODEDIR
#escribimos la fecha de la descarga
DATE1=20110717 #año mes dia 
DATE2=20110718 #año mes dia
#Nort=0
#West=0
#Sout=-90
#East=180
YY1=`echo $DATE1 | cut -c1-4`
MM1=`echo $DATE1 | cut -c5-6`
DD1=`echo $DATE1 | cut -c7-8`
YY2=`echo $DATE2 | cut -c1-4`
MM2=`echo $DATE2 | cut -c5-6`
DD2=`echo $DATE2 | cut -c7-8`

echo 'write "[centre]_[dataDate]_[dataType]_[levelType]_[step].grib[edition]";' > split.rule
#Path donde tenemos instalado grib filter.
/home/jessica/build/bin/grib_filter split.rule ERA5-${DATE1}-${DATE2}-sfc.grb
#Path donde tenemos instalado grib set
/home/jessica/build/bin/grib_set -s deletePV=1,edition=1 ERA5-${DATE1}-${DATE2}-ml.grb ERA5-${DATE1}-${DATE2}-ml.grib1
#Path donde tenemos instalado grib filter 
/home/jessica/build/bin/grib_filter split.rule ERA5-${DATE1}-${DATE2}-ml.grib1
# If you want to delete original files, you can uncomment the following line.
# rm *grb
exit 0

