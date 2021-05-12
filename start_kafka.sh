#!/bin/bash
bin/zookeeper-server-start.sh config/zookeeper.properties &
bin/kafka-server-start.sh config/server.properties &
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token= --notebook-dir="/mounted/data"
