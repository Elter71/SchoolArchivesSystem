//= require axios


Vue.component('modal', {
    template: '#modal-template',
    data: function () {
        return {
            roles: [],
            role: this.user.role_id,
            active: this.user.active,
            last_name: this.user.last_name,
            first_name: this.user.first_name,
            alert: {
                error: null,
                message: null
            }
        }
    },
    props: ['user'],
    methods: {
        getRoles: function () {
            axios({
                method: 'get',
                url: '/roles',
                responseType: 'json'
            })
                .then(response => {
                    this.roles = response.data;
                })
                .catch(function (error) {
                    console.log(error)
                });
        },
        updateUserData: function () {
            if (this.validationData()) {
                this.updateUserRequest();
            }

        },
        validationData: function () {
            this.alert.error = false;
            if (this.last_name === '') {
                this.alert.error = true;
                this.alert.message = 'Nazwisko nie może być puste.';
            }
            if (this.first_name === '') {
                this.alert.error = true;
                this.alert.message = 'Imie nie może być puste.';
            }

            return !(this.alert.error)
        },
        updateUserRequest: function () {
            axios({
                method: 'put',
                url: '/users',
                responseType: 'json',
                data: {
                    id: this.user.id,
                    role_id: this.role,
                    last_name: this.last_name,
                    first_name: this.first_name,
                    active: this.active
                }
            })
                .then(response => {
                    if (response.status == 200) {
                        this.alert.error = false;
                        this.alert.message = 'Zapisano zmiany.'
                    }
                })
                .catch(function (error) {
                });
        }
    },
    mounted() {
        this.getRoles()
    }
});

var UserList = new Vue({
    el: '#usersTable',
    data: {
        displayModal: false,
        clickedUser: [],
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
        },
        showModal: function (user) {
            this.clickedUser = user;
            this.displayModal = true;
        }
    }

});
