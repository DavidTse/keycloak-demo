#!/bin/bash -e
source bin/env.sh

KEYCLOAK_URL=https://`oc get routes keycloak -n rhsso -o jsonpath='{.spec.host}'`/auth
SERVICE_URL=https://`oc get routes demo-service -o jsonpath='{.spec.host}'`

oc get buildconfigs demo-app &>/dev/null || oc new-build --binary=true --name=demo-app
oc start-build demo-app --from-dir=demo-app --follow

oc new-app -f demo-app/demo-app.json -p KEYCLOAK_URL=$KEYCLOAK_URL -p SERVICE_URL=$SERVICE_URL
