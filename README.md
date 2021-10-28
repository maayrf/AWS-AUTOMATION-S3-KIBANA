# AWS-AUTOMATION-S3-KIBANA
Objetivo de automatizar buscas de logs relativamente antigos e realocá-los nos gráficos do Kibana. Houve a necessidade de automatizar, pois, o Kibana guarda apenas logs de aplicações dos últimos meses, os demais são deletados do gráfico, mas permanecem armazenados no S3. Quando há auditorias ou até mesmo a necessidade, esses logs tinham que ser resgatados manualmente e então surgiu a demanda.


## O AWS-AUTOMATION-S3-KIBANA
O pipeline deste projeto é baseada em scripts que recebem ranges de datas dos logs que deseja resgatar e os seus respetivos "paths". A partir disso, é dado um "invoke" no serviço Lambda já existente e irá fazer essa busca no S3 e mandar para os gráficos do Kibana.

## Instruções
Tenha acesso a uma ferramenta Postman para fazer as requisições que deseja através do método POST e com a seguinte URL:
```
https://gitlab.URL.com.br/api/v4/projects/603/trigger/pipeline?
````

Para rodar a automação de "testing" ou "production", utilize os seguintes parâmetros de variáveis no Postman:
```
token=XXXXXXXXXXXXXXXXXX
ref=main
variables[DataInicial]=2021-04-21
variables[DataFinal]=2021-04-21
variables[app]=instance-name
variables[nivel]=nivelX
variables[environment]=testing
```
> O "token" é um acesso pessoal e que deve ser criado através "Pipeline triggers".
