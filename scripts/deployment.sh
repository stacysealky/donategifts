 pwd
 cd config
 rm config.env
 echo \"$MONGODB\" >> config.env
 echo NODE_ENV=development >> config.env
 echo SESS_NAME=sid >> config.env
 echo $SESS_SECRET >> config.env
 echo SESS_LIFE=3600000 >> config.env
 echo MAILGUN_API_KEY=onlyneededforproduction >> config.env
 echo MAILGUN_DOMAIN=onlyneededforproduction >> config.env
 echo USE_AWS=true >> config.env
 echo $AWS_KEY >> config.env
 echo $AWS_SECRET >> config.env
 echo S3BUCKET=donategifts >> config.env
 echo DEFAULT_EMAIL=no-reply@donate-gifts.com >> config.env
 echo BASE_URL=https://dev.donate-gifts.com:8081 >> config.env
 echo GOOGLE_CAPTCHA_KEY= >> config.env
 echo LOCAL_DEVELOPMENT=false >> config.env
 echo SOCKET_URL=wss://dev.donate-gifts.com >> config.env
 echo $G_CLIENT_ID >> config.env
 echo $FB_APP_ID >> config.env
 echo $SLACK_INTEGRATION >> config.env
 echo $SCRAPINGBEE_APIKEY >> config.env
 echo WISHCARD_LOCK_IN_MINUTES=1 >> config.env
 pm2 restart 0
