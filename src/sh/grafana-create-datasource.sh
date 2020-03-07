#!/bin/bash
APP=Grafana
URL=$1
BASIC_AUTH=$2
ELASTICSEARCH_URL=$3

curl --fail $URL; Res=$?

if [[ $Res -eq 0 ]]
then
    echo $APP is up
    echo Creating Datasource
    curl --location --request POST "${URL}/api/datasources" \
    --header "Content-Type: application/json" \
    --header "Authorization: Basic ${BASIC_AUTH}" \
    --data-raw "{
            \"orgId\": 1,
            \"name\": \"Elasticsearch\",
            \"type\": \"elasticsearch\",
            \"typeLogoUrl\": \"public/app/plugins/datasource/elasticsearch/img/elasticsearch.svg\",
            \"access\": \"proxy\",
            \"url\": \"${ELASTICSEARCH_URL}\",
            \"password\": \"\",
            \"user\": \"\",
            \"database\": \"graylog_*\",
            \"basicAuth\": false,
            \"isDefault\": true,
            \"jsonData\": {
                \"esVersion\": 5,
                \"logLevelField\": \"\",
                \"logMessageField\": \"\",
                \"maxConcurrentShardRequests\": 256,
                \"timeField\": \"timestamp\"
            },
            \"readOnly\": false
    }"
else
    echo $APP is not running
    exit 1
fi