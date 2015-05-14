###* @jsx React.DOM ###

SearchBar = React.createClass
    _onClickSearchButtonHandler: ->
        keyword = @refs.keyword.getDOMNode().value.trim()

        if keyword isnt ""
            @props.searchSong keyword
        else
            alert "Please enter keyword."

    render: ->
        `(
            <div className="search-bar">
                <input type="text" placeholder="Song name, artist, user, ..." ref="keyword" />
                <button onClick={this._onClickSearchButtonHandler}>Search</button>
            </div>
        )`

SongList = React.createClass
    render: ->
        songList = @props.songList || []

        SongElement = `(<div className="song">
                            <p className="title">(no data)</p>
                        </div>)`

        if songList.length > 0
            SongElement = songList.map ((song, idx) ->
                `(<Song songInfo={song} getSong={this.props.getSong} />)`
            ).bind @
        `(
            <div className="song-list">
                {SongElement}
            </div>
        )`

Song = React.createClass
    _onClickSongHandler: (link) ->
        @props.getSong link

    render: ->
        songInfo = @props.songInfo

        `(
            <div className="song" onClick={this._onClickSongHandler.bind(null, songInfo.link)}>
                <p className="title">{songInfo.title}</p>
                <p>
                    <span className="artist">{songInfo.artist}</span>
                    <span className="listen">{songInfo.listen}</span>
                </p>
            </div>
        )`

Player = React.createClass
    componentDidUpdate: (prevProps, prevState) ->
        videoElement = @refs.videoElement.getDOMNode()
        videoElement.load()
        videoElement.play()

    render: ->
        songLink = @props.link || ""

        `(
            <div id="player">
                <audio controls autoplay ref="videoElement">
                    <source src={songLink} type="audio/mpeg" />
                    Your browser does not support the audio element.
                </audio>
            </div>
        )`

App = React.createClass
    getInitialState: ->
        songList: []
        songLink: ""

    componentWillMount: ->
        @nhacCuaTui = new NhacCuaTui()

    _searchSong: (keyword) ->
        songList = @nhacCuaTui.search keyword

        if songList.status
            @setState
                songList: songList.items

    _getSong: (link) ->
        songLink = @nhacCuaTui.get link

        if songLink.status
            @setState
                songLink: songLink.link

    render: ->
        `(
            <div id="wrapper">
                <SearchBar searchSong={this._searchSong} />
                <SongList songList={this.state.songList} getSong={this._getSong} />
                <Player link={this.state.songLink} />
            </div>
        )`

React.renderComponent `<App />`, document.body
