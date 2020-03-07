#!/bin/bash
APP=Grafana
URL=$1
BASIC_AUTH=$2

curl --fail $URL; Res=$?

if [[ $Res -eq 0 ]]
then
    echo $APP is up
    echo Creating Dashboard
    curl --location --request POST "${URL}/api/dashboards/db" \
    --header 'Content-Type: application/json' \
    --header "Authorization: Basic ${BASIC_AUTH}" \
    --data-raw '{
        "dashboard": {
        "annotations": {
            "list": [
            {
                "builtIn": 1,
                "datasource": "-- Grafana --",
                "enable": true,
                "hide": true,
                "iconColor": "rgba(0, 211, 255, 1)",
                "name": "Annotations & Alerts",
                "type": "dashboard"
            }
            ]
        },
        "editable": true,
        "gnetId": null,
        "graphTooltip": 0,
        "id": null,
        "links": [],
        "panels": [
            {
            "aliasColors": {},
            "bars": false,
            "dashLength": 10,
            "dashes": false,
            "datasource": "Elasticsearch",
            "fill": 1,
            "fillGradient": 0,
            "gridPos": {
                "h": 9,
                "w": 12,
                "x": 0,
                "y": 0
            },
            "hiddenSeries": false,
            "id": 2,
            "legend": {
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
            },
            "lines": true,
            "linewidth": 1,
            "nullPointMode": "null",
            "options": {
                "dataLinks": []
            },
            "percentage": false,
            "pointradius": 2,
            "points": false,
            "renderer": "flot",
            "seriesOverrides": [],
            "spaceLength": 10,
            "stack": false,
            "steppedLine": false,
            "targets": [
                {
                "bucketAggs": [
                    {
                    "field": "timestamp",
                    "id": "2",
                    "settings": {
                        "interval": "auto",
                        "min_doc_count": 0,
                        "trimEdges": 0
                    },
                    "type": "date_histogram"
                    }
                ],
                "metrics": [
                    {
                    "field": "select field",
                    "id": "1",
                    "type": "count"
                    }
                ],
                "refId": "A",
                "timeField": "timestamp"
                }
            ],
            "thresholds": [],
            "timeFrom": null,
            "timeRegions": [],
            "timeShift": null,
            "title": "Quantidade Subida API",
            "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
            },
            "type": "graph",
            "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
            },
            "yaxes": [
                {
                "format": "short",
                "label": null,
                "logBase": 1,
                "max": null,
                "min": null,
                "show": true
                },
                {
                "format": "short",
                "label": null,
                "logBase": 1,
                "max": null,
                "min": null,
                "show": true
                }
            ],
            "yaxis": {
                "align": false,
                "alignLevel": null
            }
            }
        ],
        "schemaVersion": 22,
        "style": "dark",
        "tags": [],
        "templating": {
            "list": []
        },
        "time": {
            "from": "now-6h",
            "to": "now"
        },
        "timepicker": {},
        "timezone": "",
        "title": "API Startup",
        "version": 1
        }
    }'
else
    echo $APP is not running
    exit 1
fi