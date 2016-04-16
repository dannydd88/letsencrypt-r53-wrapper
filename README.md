## Synopsis

Letsencrypt-r53-wrapper is a wrapper around [letsencrypt.sh](https://github.com/lukas2511/letsencrypt.sh). It uses a custom AWS Route53 hook written in Ruby, which is a slightly modified version of [tache's gist](https://gist.github.com/tache/3b6760784c098c9139c6) (forked from [asimihsan's gist](https://gist.github.com/asimihsan/d8d8f0f10bdc85fc6f8a)). By bringing these two solutions together you can generate Let's Encrypt certificates using the easier DNS method. Main benefit it gives you is the ability to generate the certs from a central point, like your Mac or a build server.

A more general overview of the solved problem can be found in a [blog post on Medium](https://medium.com/@paul.chmielinski/a-superior-way-to-use-let-s-encrypt-fee6bd1b7b11#.9p7ix9qre).

## Demo

### Make sure your AWS credentials are in place

They should be in `~/.aws/credentials` and have content similar to this:

```
[default]
aws_access_key_id = <your_access_key_pasted_here>
aws_secret_access_key = <your_secret_access_key_pasted_here>
```

![image](https://s3-eu-west-1.amazonaws.com/pawilon-images/letsencrypt/letsencrypt-creds.gif)

On a build server I'd recommend using a seperate IAM user, with only the necessary permissions. Here's an IAM policy that works with the hook:

```
{
    "Version": "2012-10-17",
    "Statement": {
        "Sid": "",
        "Effect": "Allow",
        "Action": [
            "route53:ChangeResourceRecordSets",
            "route53:GetChange",
            "route53:GetChangeDetails",
            "route53:ListHostedZones",
            "route53:ListHostedZonesByName"
        ],
        "Resource": [
            "*"
        ]
    }
}
```

### Clone the repository and modify domains

![image](https://s3-eu-west-1.amazonaws.com/pawilon-images/letsencrypt/letsencrypt-clone.gif)


If you're on a build server, you would want to have the config.sh and domains.txt placed elsewhere, possibly provisioned by a configuration management system.


### Run the script

![image](https://s3-eu-west-1.amazonaws.com/pawilon-images/letsencrypt/letsencrypt-run.gif)

If on a build server, also use the parameter pointing to your config

### Enjoy your valid SSL certificates

![image](https://s3-eu-west-1.amazonaws.com/pawilon-images/letsencrypt/letsencrypt-certs.gif)


## Usage

The script is extremely straightforward. It accepts up to two parameters, both optional (sorry for being lazy and not using getopts):

```
./run.sh [config_file] [AWS_region]
```

The defaults are:

```
config_file = config/config.sh
AWS_region = eu_west1
```

## License

MIT
