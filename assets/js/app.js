var jenkinsAPIEndPoint;

jenkinsAPIEndPoint = 'sample-api.json';

$(function() {
  var App;
  App = (function() {
    function App() {
      this.app = $('#app');
      this.error = $('#error');
      this.loader = $('#loader');
      this.template = $('#build');
      this.init();
    }

    App.prototype.init = function() {
      return this.removeTemplate();
    };

    App.prototype.removeTemplate = function() {
      this.template.remove();
      return this.fetchData();
    };

    App.prototype.showLoader = function() {
      return this.loader.stop().fadeIn();
    };

    App.prototype.hideLoader = function() {
      return this.loader.stop().fadeOut();
    };

    App.prototype.showError = function() {
      return this.error.stop().fadeIn();
    };

    App.prototype.hideError = function() {
      return this.error.stop().fadeOut();
    };

    App.prototype.fetchData = function() {
      var failure, success, xhr;
      success = $.proxy(this.handleFetchDataSuccess, this);
      failure = $.proxy(this.handleFetchDataFailure, this);
      xhr = $.getJSON(jenkinsAPIEndPoint);
      this.hideError();
      this.showLoader();
      return xhr.then(success, failure);
    };

    App.prototype.handleFetchDataFailure = function() {
      this.hideLoader();
      return this.showError();
    };

    App.prototype.handleFetchDataSuccess = function(data) {
      var jobs;
      jobs = data.jobs;
      if (jobs.length) {
        return this.buildJobs(jobs);
      } else {
        return this.hideLoader();
      }
    };

    App.prototype.buildJobs = function(jobs) {
      var fetchData,
        _this = this;
      fetchData = $.proxy(this.fetchData, this);
      this.app.empty();
      $.each(jobs, function(i, job) {
        var build, buildLink, _ref;
        if ((_ref = job.color) === 'disabled' || _ref === 'notbuilt') {
          return;
        }
        build = _this.template.clone();
        buildLink = build.find('a');
        build.addClass(job.color);
        build.removeAttr('id');
        buildLink.attr('href', job.url);
        buildLink.text(job.name);
        return _this.app.append(build);
      });
      this.hideLoader();
      return setTimeout(fetchData, 60000);
    };

    return App;

  })();
  return new App();
});

/*
//@ sourceMappingURL=app.js.map
*/