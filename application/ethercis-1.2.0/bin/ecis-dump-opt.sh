#!/bin/bash
# Dump the map of value path in a Template
# call in a shell, example: /opt/ecis/bin/ecis-dump-opt 'LCR Problem List.opt'

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "usage is: ecis-dump-opt <template_name_with_extension>"
    echo "the template must be locate in the local ckm path"
    echo "for example:/etc/opt/ecis/knowledge/operational_templates"
    exit -1
fi

UNAME=`uname`
export ECIS_DEPLOY_BASE=/opt/ecis
export SYSLIB=${ECIS_DEPLOY_BASE}/lib/system
export COMMONLIB=${ECIS_DEPLOY_BASE}/lib/common
export APPLIB=${ECIS_DEPLOY_BASE}/lib/application
export LIB=${ECIS_DEPLOY_BASE}/lib/deploy

# runtime parameters
export JVM=${JAVA_HOME}/bin/java
export RUNTIME_HOME=/opt/ecis
export RUNTIME_ETC=/etc/opt/ecis
export RUNTIME_LOG=/var/opt/ecis


CLASSPATH=./:\
${JAVA_HOME}/lib:\
${LIB}/ecis-core-1.2.0-SNAPSHOT.jar:\
${LIB}/ecis-knowledge-cache-1.2.0-SNAPSHOT.jar:\
${LIB}/ecis-ehrdao-1.2.0-SNAPSHOT.jar:\
${LIB}/jooq-pg-1.2.0-SNAPSHOT.jar:\
${APPLIB}/types.jar:\
${APPLIB}/ecis-openehr.jar:\
${SYSLIB}/fst-2.40-onejar.jar:\
${SYSLIB}/jersey-json-1.19.jar:\
${SYSLIB}/gson-2.4.jar:\
${SYSLIB}/commons-collections4-4.0.jar:\
${SYSLIB}/jscience-4.3.1.jar:\
${SYSLIB}/javolution-5.2.3.jar:\
${SYSLIB}/jdom-1.1.3.jar


# echo ${CLASSPATH}

# template id is passed as a command line argument

${JVM} \
-cp ${CLASSPATH} \
com.ethercis.dao.access.util.CompositionUtil \
-ckm_archetype /etc/opt/ecis/knowledge/archetypes \
-ckm_template /etc/opt/ecis/knowledge/templates \
-ckm_opt /etc/opt/ecis/knowledge/operational_templates \
-template "$1"
