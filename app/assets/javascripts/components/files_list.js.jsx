class FilesList extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            id: this.props.id_post,
            files: []
        };
        this.get_files(this.state.id)
    }

    get_files(id) {
        axios({
            method: 'get',
            url: '/files/' + id + '',
            responseType: 'json'
        })
            .then(response => {
                this.set_files_into_state(response.data);
            })
            .catch(function (error) {
                console.log(error);
            });
    }

    set_files_into_state(data) {

        this.setState({
            files: data
        });
    }

    download_zip() {
        var path = location.protocol + '//' + location.host + '/files/' + this.state.id + "/download";
        console.log("PATH" + path);
        window.location = path;
    }

    render() {
        var rows = [];
        for (var i = 0; i < this.state.files.length; i++) {
            rows.push(
                <a href={"/file/" + this.state.id + "/" + this.state.files[i]}
                   className="list-group-item">{this.state.files[i]}</a>
            )
        }
        if (rows.length > 0) {
            rows.push(
                <div className="list-group-item">
                    <button onClick={() => this.download_zip()} className="btn btn-primary">
                        Pobierz wszytkie pliki
                    </button>
                </div>);
        }
        return (
            <div className="list-group">
                {rows}
            </div>
        )
    }
}