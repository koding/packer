#!/bin/bash -x

# CALCULATE BROKER ID

FOURTHPOWER=`echo '256^3' | bc`
THIRDPOWER=`echo '256^2' | bc`
SECONDPOWER=`echo '256^1' | bc`

HOST_IP=${HOST_IP:-`curl http://169.254.169.254/latest/meta-data/local-ipv4`}

FOURTHIP=`echo $HOST_IP | cut -d '.' -f 1`
THIRDIP=`echo $HOST_IP | cut -d '.' -f 2`
SECONDIP=`echo $HOST_IP | cut -d '.' -f 3`
FIRSTIP=`echo $HOST_IP | cut -d '.' -f 4`
export KAFKA_BROKER_ID=`expr $FOURTHIP \* $FOURTHPOWER + $THIRDIP \* $THIRDPOWER + $SECONDIP \* $SECONDPOWER + $FIRSTIP`

# CALCULATE BROKER ID END



export SCALA_VERSION="2.11"
export KAFKA_VERSION="0.10.0.0"

export KAFKA_RELEASE=kafka_$SCALA_VERSION-$KAFKA_VERSION
export KAFKA_HOME=/opt/kafka
export KAFKA_LIB_DIR=/var/lib/kafka
export KAFKA_LOG_DIR=/var/log/kafka
export KAFKA_USER=kafka
export KAFKA_CONFIG_FILE=$KAFKA_HOME/config/server.properties


export KAFKA_GC_LOG_OPTS="-Xloggc:/var/log/kafka/kafkaServer-gc.log -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps"
export KAFKA_HEAP_OPTS="-Xmx256M"
export KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"
export KAFKA_JVM_PERFORMANCE_OPTS="-server -XX:+UseCompressedOops -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+CMSScavengeBeforeRemark -XX:+DisableExplicitGC -Djava.awt.headless=true"
export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:/opt/kafka/config/log4j.properties"

export JMX_PORT=9999

# not sure if this is a good place
sed "s/broker.id=0/broker.id=$KAFKA_BROKER_ID/g" $KAFKA_CONFIG_FILE > $KAFKA_CONFIG_FILE || echo $KAFKA_CONFIG_FILE
sed "s/localhost:2181/${ZOOKEEPER_CONN_STR}/g" $KAFKA_CONFIG_FILE > $KAFKA_CONFIG_FILE || echo $KAFKA_CONFIG_FILE