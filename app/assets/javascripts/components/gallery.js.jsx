class Gallery extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            id: this.props.id_post,
            images: []
        };
        this.get_images(this.state.id);
    }

    get_images(id) {
        axios({
            method: 'get',
            url: '/files/' + id + '/gallery',
            responseType: 'json'
        })
            .then(response => {
                this.set_images_into_state(response.data);
            })
            .catch(function (error) {
                console.log(error);
            });
    }

    set_images_into_state(data) {

        this.setState({
            images: data
        });
    }

    render() {
        var rows = [];
        for (var i = 0; i < this.state.images.length; i++) {
            rows.push(
                <div className="col-sm-3 center-block" style={{height: 200 + 'px', marginTop: 10 + 'px'}}>
                    <img className="img-thumbnail center"
                         style={{maxHeight: 200 + 'px', maxWidth: 200 + 'px'}}
                         src={"http://0.0.0.0:3000/file/" + this.state.id + "/" + this.state.images[i]} max/>
                </div>
            )
        }
        return (
            <div>{rows}</div>
        )
    }
}