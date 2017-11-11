class GetPage extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            display_component: Post,
            active: 3
        };
    }

    handleClick(page_index) {
        switch (page_index) {
            case 1:
                this.setState({
                    display_component: Gallery,
                    active: 1
                });
                break;
            case 2:
                this.setState({
                    display_component: FilesList,
                    active: 2
                });
                break;
            case 3:
                this.setState({
                    display_component: Post,
                    active: 3
                });
                break;
        }
    }

    is_active(id) {
        return this.state.active === id;
    }

    render() {
        return (
            <div>
                <ul className="nav nav-tabs nav-justified">
                    <ButtonDisplay onClick={() => this.handleClick(3)} active={this.is_active(3)}
                                   display_name="Szczegóły"/>
                    <ButtonDisplay onClick={() => this.handleClick(1)} active={this.is_active(1)}
                                   display_name="Galeria"/>
                    <ButtonDisplay onClick={() => this.handleClick(2)} active={this.is_active(2)}
                                   display_name="List plików"/>

                </ul>
                {React.createElement(this.state.display_component, {id_post: this.props.id_post})}
            </div>

        )
    }
}