#!/bin/sh

if [ -x ${BAMBOO_HOME}/bin/bamboo-agent.sh ]; then
    exec ${BAMBOO_HOME}/bin/bamboo-agent.sh console
else
    exec java -Dbamboo.home=${BAMBOO_HOME} -jar ${BAMBOO_INSTALL}/atlassian-bamboo/admin/agent/atlassian-bamboo-agent-installer-${BAMBOO_VERSION}.jar http://bamboo:8085/agentServer/
fi
