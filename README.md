#meme-says-jenkins

A meme based Jenkins CI monitor.

#A what?

It's a Jenkins CI monitor that haz memes. There are 3:

1. When things are going really badly, disabled or not yet built: ![image](https://raw.github.com/ahmednuaman/meme-says-jenkins/master/assets/img/build-red.jpg)
2. When things are getting there, a few failed tests: ![image](https://raw.github.com/ahmednuaman/meme-says-jenkins/master/assets/img/build-yellow.jpg)
3. When things are going great and there's much success: ![image](https://raw.github.com/ahmednuaman/meme-says-jenkins/master/assets/img/build-blue.jpg)
4. And when things are building or about to be built: ![image](https://raw.github.com/ahmednuaman/meme-says-jenkins/master/assets/img/build-grey.jpg)

#Demo

Here's a little demo that uses Apache's CI feed: [http://ahmednuaman.github.io/meme-says-jenkins/](http://ahmednuaman.github.io/meme-says-jenkins/)

#How do use

1. Clone the repo and stick it on your desired monitor machine, whether it's on your CI server or a dedicated machine in your place of work.
2. If you've allowed `JSONP` on Jenkins then go ahead and edit the [`app.coffee`](https://github.com/ahmednuaman/meme-says-jenkins/blob/master/assets/js/app.coffee) file and change `jenkinsAPIEndPoint` to the `JSONP` end point of your CI server, eg: `https://builds.apache.org/api/json?format=json&jsonp=?`.
3. If you've not got the beauty of `JSON` then you can use the built in NodeJS server, simply edit the [`app.coffee`](https://github.com/ahmednuaman/meme-says-jenkins/blob/master/assets/js/app.coffee) file and change `jenkinsAPIEndPoint` to `api.json`, then edit [`server.coffee`](https://github.com/ahmednuaman/meme-says-jenkins/blob/master/server.coffee) and change `jenkinsAPIEndPoint` to then JSON end point of your CI server, eg: `https://builds.apache.org/api/json`.
4. Rejoice.