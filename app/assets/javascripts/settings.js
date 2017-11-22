//= require axios
var UserList = new Vue({
    el: '#usersTable',
    data: {
        users: []
    },
    mounted() {
        this.getUsers()
    },
    methods: {
        getUsers: function () {
            axios({
                method: 'get',
                url: '/users',
                responseType: 'json'
            })
                .then(response => {
                    this.users = response.data;
                })
                .catch(function (error) {
                    console.log(error)
                });
        }
    }

});
