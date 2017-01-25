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
      tableFilter: function () {
        return this.findBy(this.leads, this.searchField, ['name', 'company', 'job_title', 'email', 'phone', 'notes', 'current_step' ])
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
      orderCurrentStep: function() {
        this.toggleSortOrder();
        if (this.sortOrder === "desc") {
          this.leads = _.orderBy(this.leads, [lead => lead["progress_level"]], ['desc']);
        } else {
          this.leads = _.orderBy(this.leads, [lead => lead["progress_level"]], ['asc']);
        }
          return this.leads;
      },
      toggleSortOrder: function() {
        if (this.sortOrder === "desc"){
          this.sortOrder = "asc";
        } else {
          this.sortOrder = "desc";
        }
      },
      findBy: function (list, value, column) {
        return list.filter(function (item) {
          var searchMatch = false;
          
          for(var i = 0; i < column.length; i++) {
            var itemAttribute = column[i];
            var result = item[itemAttribute].toLowerCase().indexOf(value.toLowerCase()) !== -1;
            if(result) {
              searchMatch = true;
            }
          }
          return searchMatch;
        })
      },
      urlBuilder: function(leadId) {
        return "/users/" + gon.user_id + "/leads/" + leadId;
      }
    }
  })
})