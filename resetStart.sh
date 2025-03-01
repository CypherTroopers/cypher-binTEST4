#!/bin/sh
GENESISDIR="./genesis.json"
OUTPUTLOG="cypherlog.txt"
ostype()
{
  osname=`uname -s`
  #echo "osname $osname"
  OSTYPE=UNKNOWN
  case $osname in
     "FreeBSD") OSTYPE="freebsd"
     ;;
     "SunOS") OSTYPE="solaris"
     ;;
     "Linux") OSTYPE="linux"
     ;;
     "Darwin") OSTYPE="darwin"
     ;;
     "linux") OSTYPE="linux"
     ;;
     "darwin") OSTYPE="darwin"
     ;;
     *) echo "other system $osname"
     ;;
    esac
  return 0
}
ostype
select=$2

CHAINDB="./database/chaindb"
BINDIR="./database/$OSTYPE/cypher"
if [[ "$select" == "test" ]];then
        BINDIR="./database/$OSTYPE/cyphertest"
        CHAINDB="./database/chaindbtest"
        GENESISDIR="./genesistest.json"
        OUTPUTLOG="cypherlogtest.txt"
fi

#echo "CHAINDB $CHAINDB"
#echo "BINDIR $BINDIR"

#sudo rm -rf $CHAINDB/cypher/* $OUTPUTLOG
sudo rm -rf $OUTPUTLOG
$BINDIR --datadir $CHAINDB init $GENESISDIR
./start.sh $1 $2
