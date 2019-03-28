RED='\033[0;31m'
NC='\033[0m' # No Color

CMD="jpsvis"
VERSION=0.8.4


#cd ..
# check if dependencies to libs are local to .app
python checkDependencies.py bin/jpsvis.app/

appdmg Resources/dmg.json ${CMD}-${VERSION}.dmg
