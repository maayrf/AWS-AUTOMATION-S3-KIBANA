#!/bin/bash
echo "Iniciando script de loop..."
di=$1
df=$2
app=$3
nivel=$4
environment=$5

case "$environment" in
  #case 1
  "testing") ambiente="bucket-name-test"
  echo "[default]" > ~/.aws/config && echo "output = json" >> ~/.aws/config && echo "region = us-west-2" >> ~/.aws/config
  break;;
  #case 2
  "production") ambiente="bucket-name-prod"
  echo "[default]" > ~/.aws/config && echo "output = json" >> ~/.aws/config && echo "region = us-east-1" >> ~/.aws/config
  break;;
  #case 3
  *) echo "ESSE AMBIENTE NÃO EXISTE"
  exit 1;;
esac

di=`date +%Y-%m-%d -d ${di}`
exitCodeDI=$?
[ $exitCodeDI -eq 0 ] && echo "Data Inicial ${di}" || exit 1

df=`date +%Y-%m-%d -d ${df}`
exitCodeDF=$?
[ $exitCodeDF -eq 0 ] && echo "Data Final ${df}" || exit 1

# Se data inicial for maior que a data final...
if [ "$(echo "$di" | tr -d -)" -gt "$(echo "$df" | tr -d -)" ];
then
  echo "A data inicial deve ser inferior a data final!"
  exit 1
fi

df=$(date -I -d "$df + 1 day")
while [ "$di" != "$df" ]; 
do 
  dano=$(date -d "$di" +%Y)
  dmes=$(date -d "$di" +%m)
  ddia=$(date -d "$di" +%d)
  for I in `aws s3api list-objects-v2 --bucket ${ambiente} --prefix ${nivel}/services/app_logs/${app}/${dano}/${dmes}/${ddia} | jq -r ".Contents[] | .Key "`; 
  do 
    A=$(echo $I | sed 's/\//\\\//g');
	cat paths3.json | sed -E -e "s/name_ambiente/$ambiente/g" -e "s/key_do_arquivo/$A/g" > paths3lambda.json;
    sh lambdainvoke.sh
  done
  di=$(date -I -d "$di + 1 day")
done
