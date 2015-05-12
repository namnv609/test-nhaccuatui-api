NhacCuaTui = ->
    _apiSettings =
        apiURL: "http://m.nhaccuatui.com/tim-kiem/bai-hat?q="
        endpointURL: "https://query.yahooapis.com/v1/public/yql?q="

    _yqlExecuteQuery = (yqlStatement) ->
        yqlResult = {}
        $.ajax
            url: "#{_apiSettings.endpointURL}#{encodeURIComponent yqlStatement}&format=json"
            cache: no
            async: no
            success: (response) ->
                yqlResult = response
            error: (xmlHttpReq, ajaxOpts, error) ->
                console.log error

        yqlResult

    @search = (keyword) ->
        # Mã hóa từ khóa sang dạng URI #
        keyword = encodeURIComponent keyword.trim()
        # Object chứa status và mảng object kết quả #
        result =
            status: false
            items: []

        if keyword isnt ""
            yqlStatement = "SELECT * FROM html WHERE url='#{_apiSettings.apiURL + keyword}' AND xpath='//div[contains(@class, \"bgmusic\")]'"
            yqlResult = _yqlExecuteQuery yqlStatement

            if yqlResult.query.count > 0
                result.status = true
                $.each yqlResult.query.results.div, (idx, item) ->
                    result.items.push
                        title: song.h3.a.title
                        link: song.h3.a.href
                        artist: song.p.content
                        listen: song.p.span.content

            result

    @get = (link) ->
        result =
            status: false
            link: ""

        if link.trim() isnt ""
            yqlStatement = "SELECT * FROM html WHERE url='#{link}' AND xpath='//div[@class=\"download\"]//'"
            yqlResult = _yqlExecuteQuery yqlStatement
            if yqlResult.query.count > 0
                result =
                    status: true
                    link: yqlResult.query.results.a.href

        result

    return
