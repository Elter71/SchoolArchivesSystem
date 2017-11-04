new Vue({
    el: '#role',
    data: {
        users: [],
        roles: [],
        table_role_menu: [],
        selected_role: []


    },
    created() {
        this.buildRoles();
        this.buildUsers();
    },
    methods: {
        buildUsers: function () {
            var that = this;
            $.ajax({
                method: 'GET',
                url: '/users',
                dataType: "json",
                success: function (res) {
                    that.users = res;
                    for (id in that.users) {
                        that.table_role_menu.push({id: that.users[id].id, isActive: false});
                    }
                }

            });
        },
        buildRoles: function () {
            var that = this;
            $.ajax({
                method: 'GET',
                url: '/roles',
                dataType: "json",
                success: function (res) {
                    that.roles = res;
                    for (id in that.roles) {
                        that.selected_role.push({id: that.roles[id].id, isSelected: false});
                    }
                }
            });
        },
        show_list: function (user) {
            for (id in this.table_role_menu) {
                if (this.table_role_menu[id].isActive)
                    return;
            }
            for (id in this.roles) {
                var role = this.roles[id];
                if (role.id === user.role_id) {
                    this.selected_role[role.id - 1].isSelected = true;
                }
            }
            this.get_user_table_active(user).isActive = true
        },
        save_change: function (user) {
            var that = this;
            for (id in this.selected_role) {
                if (this.selected_role[id].isSelected)
                    user.role_id = this.selected_role[id].id;
                this.selected_role[id].isSelected = false;
            }
            $.ajax({
                url: '/users',
                type: 'PUT',
                data: {
                    user
                },
                success: function (data) {
                    alert('Zapiano pomyślnie');
                },
                error: function (xhr, err) {
                    alert("readyState: " + xhr.readyState + "\nstatus: " + xhr.status);
                    alert("responseText: " + xhr.responseText);
                }

            });
            this.get_user_table_active(user).isActive = false;
        },
        select_role: function (role_id) {
            for (id in this.roles) {
                var _role = this.roles[id];
                if (_role.id != role_id) {
                    this.selected_role[_role.id - 1].isSelected = false;
                }
            }
            this.selected_role[role_id - 1].isSelected = true;
        },
        get_user_role: function (role_id) {
            for (id in this.roles) {
                if (this.roles[id].id == role_id) {
                    return this.roles[id].name;
                }

            }
        },
        row_is_active: function (user) {
            for (id in this.table_role_menu) {
                row = this.table_role_menu[id];
                if (row.id == user.id) {
                    return row.isActive
                }
            }
        },
        get_user_table_active: function (user) {
            for (id in this.table_role_menu) {
                row = this.table_role_menu[id];
                if (row.id == user.id) {
                    return row
                }
            }
        }
    }
})

