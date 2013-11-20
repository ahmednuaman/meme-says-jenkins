jenkinsAPIEndPoint = 'api.json'

$ () ->
  class App
    constructor: () ->
      @app = $ '#app'
      @error = $ '#error'
      @loader = $ '#loader'
      @template = $ '#build'

      @init()

    init: () ->
      @removeTemplate()

    removeTemplate: () ->
      @template.remove()
      @fetchData()

    showLoader: () ->
      @loader.stop().fadeIn()

    hideLoader: () ->
      @loader.stop().fadeOut()

    showError: () ->
      @error.stop().fadeIn()

    hideError: () ->
      @error.stop().fadeOut()

    fetchData: () ->
      success = $.proxy @handleFetchDataSuccess, @
      failure = $.proxy @handleFetchDataFailure, @
      xhr = $.getJSON jenkinsAPIEndPoint

      @hideError()
      @showLoader()

      xhr.then success, failure

    handleFetchDataFailure: () ->
      @hideLoader()
      @showError()

    handleFetchDataSuccess: (data) ->
      jobs = data.jobs

      if jobs.length
        @buildJobs jobs

      else
        @hideLoader()

    buildJobs: (jobs) ->
      fetchData = $.proxy @fetchData, @

      @app.empty()

      $.each jobs, (i, job) =>
        build = @template.clone()
        buildLink = build.find 'a'

        build.addClass job.color
        build.removeAttr 'id'

        buildLink.attr 'href', job.url
        buildLink.text job.name

        @app.append build

      @hideLoader()

      # setTimeout fetchData, 3000

  new App()