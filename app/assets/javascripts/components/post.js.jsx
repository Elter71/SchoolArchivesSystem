class Post extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            id: this.props.id_post,
            title: "",
            description: "",
            tag: "",
            thumbnail: "",
            created_at: "",
            author_full_name: props.author_full_name,
            image_error: false
        };
    }

    componentDidMount() {
        this.get_post_by_id(this.state.id);

    }


    render_request_data(data) {
        this.setState({
            id: data.id,
            title: data.title,
            description: data.description,
            tag: data.tag,
            thumbnail: data.thumbnail,
            created_at: data.created_at,
        });
        this.get_user_by_id(data.user_id);

    }

    add_full_name(data) {
        this.setState({
            author_full_name: data.first_name + " " + data.last_name
        });
    }

    get_post_by_id(id) {
        axios({
            method: 'get',
            url: '/post/' + id + '.json',
            responseType: 'json'
        })
            .then(response => {
                this.render_request_data(response.data);
            })
            .catch(function (error) {
                console.log(error);
            });
    }

    get_user_by_id(id) {
        axios({
            method: 'get',
            url: '/user/' + id,
            responseType: 'json'
        })
            .then(response => {
                this.add_full_name(response.data);
            })
            .catch(function (error) {
                console.log(error);
            });
    }

    handleError() {
        this.setState({image_error: true});
    }

    get_root_path() {
        var path = location.protocol + '//' + location.host + "/";
        return path;
    }

    render() {
        var img = <img className="img-thumbnail" onError={() => this.handleError()}
                       src={this.get_root_path() + "file/" + this.state.id + "/" + this.state.thumbnail}/>
        if (this.state.image_error) {
            img = <img className="img-thumbnail" onError={() => this.handleError()}
                       src={this.get_root_path() + "notfound.jpg"}/>
        }

        return (
            <div><h2>{this.state.title}</h2><h5><span className="glyphicon glyphicon-time"/> Dodany
                przez {this.state.author_full_name},
                {this.state.created_at}</h5><h5><span className="label label-info">{this.state.tag}</span></h5>
                <div className="row">
                    <div className="col-sm-3">
                        {img}
                    </div>
                    <div className="col-sm-8"><p>
                        {this.state.description}
                    </p></div>
                </div>
            </div>);
    }
}