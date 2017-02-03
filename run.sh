set -e
set -x

CONFIG="config/config.sh"

which bundle
if [ $? != 0 ]; then
  echo "Installing bundler"
  gem install bundler
fi

if [ ! -z $1 ]; then
  export CONFIG="$1"
fi

if [ ! -z $2 ]; then
  export AWS_REGION="$2"
else
  export AWS_REGION="eu-west1" 
fi

bundle exec ./letsencrypt.sh/dehydrated.sh --accept-terms --cron --config "$CONFIG"
