#!/bin/sh -e

case "$1" in
    agent)
        if [ -d /srv/bamboo-agent.d ]; then
            for f in $(find /srv/bamboo-agent.d -type f | sort); do
                case "$f" in
                    *.sh)   echo "$0: sourcing $f"; . "$f" ;;
                    *)      echo "$0: ignoring $f" ;;
                esac
            done

            if [ -x ${BAMBOO_HOME}/bin/bamboo-agent.sh ]; then
                exec ${BAMBOO_HOME}/bin/bamboo-agent.sh console
            else
                exec java -Dbamboo.home=${BAMBOO_HOME} -jar ${BAMBOO_INSTALL}/atlassian-bamboo/admin/agent/atlassian-bamboo-agent-installer-${BAMBOO_VERSION}.jar http://${BAMBOO_SERVER:-bamboo}:8085/agentServer/
            fi
        fi
    ;;
    server)
        if [ -d /srv/bamboo.d ]; then
            for f in $(find /srv/bamboo.d -type f | sort); do
                case "$f" in
                    *.sh)   echo "$0: sourcing $f"; . "$f" ;;
                    *)      echo "$0: ignoring $f" ;;
                esac
            done
        fi
        exec ${BAMBOO_INSTALL}/bin/start-bamboo.sh -fg
    ;;
    *)
        exec "$@"
    ;;
esac
