//= require axios


new Vue({
    el: '#postList',
    methods: {
        deletePost: function (id) {
            axios({
                method: 'delete',
                url: '/post/'+id,
                responseType: 'json'
            })
                .then(response => {
                    alert('Post usunięty pomyślnie.');
                    location.reload();
                })
                .catch(function (error) {
                    alert('Nie można usunąć postu.');
                    location.reload();
                });
        }
    }
});