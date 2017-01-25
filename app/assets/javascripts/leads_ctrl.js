$(document).ready(function() {
  new Vue({
    el: '#leads-index',
    data: {
      leads: [],
      numbers: ["1", "2", "3"],
      sortOrder: "desc",
      searchField: ""
    },
    mounted: function() {
      var that; 
      that = this;
      $.ajax({
        url: '/api/v1/users/' + gon.user_id +'/leads.json',
        success: function(response) {
          that.leads = response;
        }
      })
    },
    computed: {
      orderedLeads: function() {
        return _.orderBy(this.leads, 'name')
      },
      tableFilter: function () {
        return this.findBy(this.leads, this.searchField, 'name')
      }
    },
    methods: {
      orderByField: function(field) {
        this.toggleSortOrder();
        if (this.sortOrder === "desc") {
          this.leads = _.orderBy(this.leads, [lead => lead[field].toLowerCase()], ['desc']);
        } else {
          this.leads = _.orderBy(this.leads, [lead => lead[field].toLowerCase()], ['asc']);
        }
          return this.leads;
      },
      toggleSortOrder: function() {
        if (this.sortOrder === "desc"){
          this.sortOrder = "asc";
        } else {
          this.sortOrder = "desc";
        }
        console.log(this.sortOrder);
      },
      findBy: function (list, value, column) {
        return list.filter(function (item) {
          return item[column].indexOf(value) !== -1;
        })
      }
    }
  })
})