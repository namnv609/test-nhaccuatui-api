###* @jsx React.DOM ###

SearchBar = React.createClass
    render: ->
        `(
            <div className="search-bar">
                <input type="text" placeholder="Song name, artist, user, ..." ref="keyword" />
                <button>Search</button>
            </div>
        )`

SongList = React.createClass
    render: ->
        `(
            <div className="song-list">
                <Song />
            </div>
        )`

Song = React.createClass
    render: ->
        Element = `(<div className="song">
                        <p className="title">Song name</p>
                        <p>
                            <span className="artist">Artist</span>
                            <span className="listen">000,000</span>
                        </p>
                    </div>)`

        `(
            <div>
                {Element}
            </div>
        )`

App = React.createClass
    getInitialState: ->
        songList: []

    componentWillMount: ->
        @nhacCuaTui = new NhacCuaTui();

    render: ->
        console.log @nhacCuaTui

        `(
            <div id="wrapper">
                <SearchBar />
                <SongList />
            </div>
        )`

React.renderComponent `<App />`, document.body