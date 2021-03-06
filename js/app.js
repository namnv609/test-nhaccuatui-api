// Generated by CoffeeScript 1.8.0

/** @jsx React.DOM */
var App, Player, SearchBar, Song, SongList;

SearchBar = React.createClass({
  _onClickSearchButtonHandler: function() {
    var keyword;
    keyword = this.refs.keyword.getDOMNode().value.trim();
    if (keyword !== "") {
      return this.props.searchSong(keyword);
    } else {
      return alert("Please enter keyword.");
    }
  },
  render: function() {
    return (
            <div className="search-bar">
                <input type="text" placeholder="Song name, artist, user, ..." ref="keyword" />
                <button onClick={this._onClickSearchButtonHandler}>Search</button>
            </div>
        );
  }
});

SongList = React.createClass({
  render: function() {
    var SongElement, songList;
    songList = this.props.songList || [];
    SongElement = (<div className="song">
                            <p className="title">(no data)</p>
                        </div>);
    if (songList.length > 0) {
      SongElement = songList.map((function(song, idx) {
        return (<Song songInfo={song} getSong={this.props.getSong} />);
      }).bind(this));
    }
    return (
            <div className="song-list">
                {SongElement}
            </div>
        );
  }
});

Song = React.createClass({
  _onClickSongHandler: function(link) {
    return this.props.getSong(link);
  },
  render: function() {
    var songInfo;
    songInfo = this.props.songInfo;
    return (
            <div className="song" onClick={this._onClickSongHandler.bind(null, songInfo.link)}>
                <p className="title">{songInfo.title}</p>
                <p>
                    <span className="artist">{songInfo.artist}</span>
                    <span className="listen">{songInfo.listen}</span>
                </p>
            </div>
        );
  }
});

Player = React.createClass({
  componentDidUpdate: function(prevProps, prevState) {
    var videoElement;
    videoElement = this.refs.videoElement.getDOMNode();
    videoElement.load();
    return videoElement.play();
  },
  render: function() {
    var songLink;
    songLink = this.props.link || "";
    return (
            <div id="player">
                <audio controls autoplay ref="videoElement">
                    <source src={songLink} type="audio/mpeg" />
                    Your browser does not support the audio element.
                </audio>
            </div>
        );
  }
});

App = React.createClass({
  getInitialState: function() {
    return {
      songList: [],
      songLink: ""
    };
  },
  componentWillMount: function() {
    return this.nhacCuaTui = new NhacCuaTui();
  },
  _searchSong: function(keyword) {
    var songList;
    songList = this.nhacCuaTui.search(keyword);
    if (songList.status) {
      return this.setState({
        songList: songList.items
      });
    }
  },
  _getSong: function(link) {
    var songLink;
    songLink = this.nhacCuaTui.get(link);
    if (songLink.status) {
      return this.setState({
        songLink: songLink.link
      });
    }
  },
  render: function() {
    return (
            <div id="wrapper">
                <SearchBar searchSong={this._searchSong} />
                <SongList songList={this.state.songList} getSong={this._getSong} />
                <Player link={this.state.songLink} />
            </div>
        );
  }
});

React.renderComponent(<App />, document.body);
