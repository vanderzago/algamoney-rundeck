#!/bin/bash
APP=Graylog
URL=$1
BASIC_AUTH=$2

curl --fail $URL; Res=$?

if [[ $Res -eq 0 ]]
then
    echo $APP is up
    echo Creating Input
    curl --location --request POST "${URL}/api/system/inputs" \
    --header 'Accept: application/json' \
    --header 'Content-Type: application/json' \
    --header "Authorization: Basic ${BASIC_AUTH}" \
    --header 'X-Requested-By: cli' \
    --data-raw '{
            "title": "Algamoney-API",
            "type": "org.graylog2.inputs.gelf.udp.GELFUDPInput",
            "global": true,
            "configuration":   {
                "recv_buffer_size": 1048576,
                "tcp_keepalive": false,
                "use_null_delimiter": true,
                "number_worker_threads": 2,
                "tls_client_auth_cert_file": "",
                "bind_address": "0.0.0.0",
                "tls_cert_file": "",
                "decompress_size_limit": 8388608,
                "port": 12201,
                "tls_key_file": "",
                "tls_enable": false,
                "tls_key_password": "",
                "max_message_size": 2097152,
                "tls_client_auth": "disabled",
                "override_source": null
                },
            "node": null
        }'
else
    echo $APP is not running
    exit 1
fi