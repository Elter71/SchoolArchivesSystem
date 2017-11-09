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
            author_full_name: props.author_full_name
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
            created_at: data.created_at
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


    render() {
        return (
            <div><h2>{this.state.title}</h2><h5><span className="glyphicon glyphicon-time"></span> Dodany
                przez {this.state.author_full_name},
                {this.state.created_at}</h5><h5><span className="label label-info">{this.state.tag}</span></h5>
                <div className="row">
                    <div className="col-sm-3"><img className="img-thumbnail"
                                                   src={"http://0.0.0.0:3000/file/" + this.state.id + "/" + this.state.thumbnail}/>
                    </div>
                    <div className="col-sm-8"><p>
                        {this.state.description}
                    </p></div>
                </div>
            </div>)
    }
}