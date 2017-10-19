
echo "DO NOT RUN THIS, THESE ARE SNIPPETS. COPY PASTE AND EDIT!"
exit 1

export repository=TheFineRepositoryFolderNameToBeCreatedinS3
export snapshot=Snapshot1Name
export instance=SourceAwsInstance

# Start create snapshot from SourceAwsInstace
curl -XPUT "https://${instance}/_snapshot/${repository}/${snapshot}"

# Check status of repository
curl -XGET "https://${instance}/_snapshot/${repository}/_all?pretty"

# Restore snapshot to DestinationAwsInstance
export instance=DestinationAwsInstance
curl -XPOST "https://${instance}/_snapshot/${repository}/${snapshot}/_restore"

# Restore some indices (without .kibana) to DestinationAwsInstance
curl -XPOST "https://${instance}/_snapshot/${repository}/${snapshot}/_restore" -d '{"indices": "logstash-*"}'

# List all ES indexes
curl "https://${instance}/_cat/indices?v"

# Delete one or more indices from ES
curl -XDELETE "https://${instance}/logstash-prod-2017.10.12,logstash-test-2017.10.12"

export snapshot=2017-10-16t15-06-snapshot
# 2017-10-16 restore new indices between last two snapshots (remember to delete the overlapping ones first).
# Excluded 16.10. as it will be snapshot tomorrow
curl -XPOST "https://${instance}/_snapshot/${repository}/${snapshot}/_restore" -d '{"indices": "logstash-prod-2017.10.12,logstash-prod-2017.10.13,logstash-prod-2017.10.14,logstash-prod-2017.10.15,logstash-test-2017.10.12,logstash-test-2017.10.13,logstash-test-2017.10.14,logstash-test-2017.10.15"}'

export snapshot=Snapshot2Name
# 2017-10-17 Start incremental snapshot from SourceAwsInstace
curl -XPUT "https://${instance}/_snapshot/${repository}/${snapshot}"

# 2017-10-17 restore new indices between last two snapshots, now the history is complete
curl -XPOST "https://${instance}/_snapshot/${repository}/${snapshot}/_restore" -d '{"indices": "logstash-prod-2017.10.16,logstash-prod-2017.10.17,logstash-test-2017.10.16,logstash-test-2017.10.17"}'

