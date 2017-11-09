class ButtonDisplay extends React.Component {

    is_active() {
        return this.props.active ? "active" : "";
    }

    render() {
        return (
            <li className={this.is_active()}><a onClick={this.props.onClick}>{this.props.display_name}</a></li>
        )
    }
}