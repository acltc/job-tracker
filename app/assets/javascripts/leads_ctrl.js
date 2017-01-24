$(document).ready(function() {
  new Vue({
    el: '#leads-index',
    data: {
      leads: [],
      numbers: ["1", "2", "3"],
      user_id: ""
    },
    mounted: function() {
      var that; 
      that = this;
      $.ajax({
        url: '/api/v1/users/1/leads.json',
        success: function(response) {
          that.leads = response;
        }
      })
    }
  })
})