# Today's Beer

Tweets random beers from online shops like Amazon and Rakuten.

## Deployment

Deploy to Heroku and configure Heroku Scheduler to run `bin/random_beer` hourly. This configuration consumes only one-off dynos.

Make sure to set environmental variables on Heroku. You can easily push your local `.env` file to Heroku with heroku-config plugin.

```
heroku plugins:install git://github.com/ddollar/heroku-config.git
heroku config:push
```
