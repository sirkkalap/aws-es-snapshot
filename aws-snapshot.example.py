"""Sample Python Clien from AWS ES Service documentation

Edit the region, host, aws_access_key_id, aws_secret_access_key and path
according the documentation at
http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-managedomains-snapshots.html

"""

from boto.connection import AWSAuthConnection

class ESConnection(AWSAuthConnection):

    def __init__(self, region, **kwargs):
        super(ESConnection, self).__init__(**kwargs)
        self._set_auth_region_name(region)
        self._set_auth_service_name("es")

    def _required_auth_capability(self):
        return ['hmac-v4']

if __name__ == "__main__":

    client = ESConnection(
            region='us-east-1',
            host='search-weblogs-etrt4mbbu254nsfupy6oiytuz4.us-east-1.es.example.com',
            aws_access_key_id='my-access-key-id',
            aws_secret_access_key='my-access-key', is_secure=False)

    print 'Registering Snapshot Repository'
    resp = client.make_request(method='POST',
            path='/_snapshot/weblogs-index-backups',
            data='{"type": "s3","settings": { "bucket": "es-index-backups","region": "us-east-1","role_arn": "arn:aws:iam::123456789012:role/MyElasticsearchRole"}}')
    body = resp.read()
    print body
