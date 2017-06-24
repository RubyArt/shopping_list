class Dashboard extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      stats: []
    };
  }

  componentDidMount() {
    $.ajax({
      method: "GET",
      dataType: "json",
      url: "/dashboard/user_data.json"
    }).then(response => {
      this.setState({stats: response});
    });
  }

  render() {
    return (
      <div>
        <h1>Dashboard for {this.props.user_name}</h1>

        <ul>
            {this.state.stats.map(stat =>
              <li key={stat[0]}><b>{stat[0]}:</b> {stat[1]}</li>
            )}
        </ul>
      </div>
    )
  }
}
