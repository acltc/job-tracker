$(document).ready(function() {
  new Vue({
    el: '#leads-index',
    data: {
      leads: [],
      numbers: ["1", "2", "3"],
      user_id: "",
      sortOrder: "desc"
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
      }
    },
    methods: {
      orderByField: function() {
        this.toggleSortOrder();
        if (this.sortOrder === "desc") {
          this.leads = _.orderBy(this.leads, 'name', ['desc']);
          return this.leads;
        } else {
          this.leads = _.orderBy(this.leads, 'name', ['asc']);
          return this.leads;
        }
      },
      toggleSortOrder: function() {
        if (this.sortOrder === "desc"){
          this.sortOrder = "asc";
        } else {
          this.sortOrder = "desc";
        }
        console.log(this.sortOrder);
      }
    }
  })
})