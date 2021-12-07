#!/bin/bash -e
source bin/env.sh

KEYCLOAK_URL=https://`oc get routes keycloak -n rhsso -o jsonpath='{.spec.host}'`/auth

oc get buildconfigs demo-service &>/dev/null || oc new-build --binary=true --name=demo-service
oc start-build demo-service --from-dir=demo-service --follow

oc new-app -f demo-service/demo-service.json -p KEYCLOAK_URL=$KEYCLOAK_URL
