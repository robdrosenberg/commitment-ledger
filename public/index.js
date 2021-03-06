/* global Vue, VueRouter, axios */
Vue.component('vue-multiselect', window.VueMultiselect.default)



var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Commitment Ledger"
    };
  },
  created: function() {},
  methods: {},
  computed: {}
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      first_name: "",
      last_name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        first_name: this.first_name,
        last_name: this.last_name,
        user_name: this.user_name,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/commitments");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var CommitmentsPage = {
  template: "#commitments-page",
  components: {
    Multiselect: window.VueMultiselect.default
  },
  data: function() {
    return {
      message: "All Your Commitments",
      commitments: [],
      value: [],
      updateValue: [],
      people: [],
      selected_people: [],
      newCommitment: {
        what: "",
        who: "",
        due: "",
        notes: "",
        category_id: "",

      },
      currentCommitment: {},
      statusFilter: "",
      categoryFilter: "",
      sortAttribute: "what",
      sortAscending: true,
      sortIcon: "",
      countCommitments: 0,
      showWarning: false,
      errors: []
    };
  },
  created: function() {
    axios.get("/commitments").then(function(response){
      this.commitments = response.data;
      console.log(response.data);
      var count = 0;
      this.commitments.forEach(function(commitment){
        if (commitment.status == "Committed"){
          count++;
        }
      }.bind(this));
      this.countCommitments = count;
      console.log(this.countCommitments);
    }.bind(this));
    axios.get("/people").then(function(response){
      this.people = response.data;
      console.log(this.people);
    }.bind(this));
  },
  methods: {
    addCommitment: function(){
      // console.log(people);
      // var shownVal= document.getElementById("person_name").value;
      // var valForParams=document.querySelector("#names option[value='"+shownVal+"']").dataset.value;
      // console.log(shownVal);
      // console.log(valForParams);
      var params = {
        
        what: this.newCommitment.what,
        who: this.newCommitment.who,
        due: this.newCommitment.due,
        notes: this.newCommitment.notes,
        category_id: this.newCommitment.category_id
      };

      axios.post("/commitments", params).then(function(response){
        console.log(response.data);

        commitment = response.data;
        this.countCommitments++;
        if (this.countCommitments >= 5){
          // message = "Be wary of over committing! "
          this.showWarning = true;
        } else {
          this.showWarning = false;
        }
        var new_id = commitment.id;
        this.newCommitment.what = "";
        this.newCommitment.who = "";
        this.newCommitment.due = "";
        this.newCommitment.notes = "";
        this.newCommitment.category_id = "";
        this.value.forEach(function(person){
          var people_params = {
            commitment_id: new_id,
            person_id: person.id
          }
          axios.post("/commitment_people", people_params).then(function(response){
            console.log(response.data)
          }.bind(this));
          
        });
        axios.get("/commitments").then(function(response){
            this.commitments = response.data
            var count = this.countCommitments
            console.log(count + "???");
            if (count >= 5){
              // message = "Be wary of over committing! "
              this.showWarning = true;
            } else {
              this.showWarning = false;
            }
            // return "Current Commitments: " + count;
          }.bind(this));

      }.bind(this)).catch(function(error){
        console.log(error);
        this.errors = error.response.data.errors;
      }.bind(this));
      
    },
    deleteCommitment: function(commitment){
      var id = commitment.id;
      console.log("deleted " + id);

      axios.delete("/commitments/"+ id).then(function(response){
        var index = this.commitments.indexOf(commitment);
        if (commitment.status === "Committed") {
          this.countCommitments--;
        }
        this.commitments.splice(index,1);
      }.bind(this));
    },
    setCurrentCommitment: function(commitment){
      this.currentCommitment = commitment;
      console.log(commitment);
      console.log(commitment.due);
      console.log(this.currentCommitment.id);
      this.selected_people = [];

      this.updateValue = commitment.people;
      this.people.forEach(function(person){
        if (!this.updateValue.includes(person)) {
          this.selected_people.push(person);
        }
      }.bind(this));
      console.log(this.updateValue);
    },
    updateCommitment: function(commitment){
      // var nameVal= document.getElementById("update_who").value;
      // var updatePersonVal=document.querySelector("#people_names option[value='"+nameVal+"']").dataset.value;
      // console.log(nameVal);
      // console.log(updatePersonVal);
      var params = {
        what: this.currentCommitment.what,
        who: this.currentCommitment.who,
        due: this.currentCommitment.due,
        notes: this.currentCommitment.notes,
        status: this.currentCommitment.status,
        category_id: this.currentCommitment.category_id
      };
      console.log("your" + params)
      axios.put("/commitments/" + commitment.id, params).then(function(response){
        console.log(this.currentCommitment);
        console.log(response.data);
        var updatedCommitment = response.data;
        var update_id = updatedCommitment.id;
        // this.commitments.push(response.data);

        this.updateValue.forEach(function(person){
          var update_people_params = {
            commitment_id: update_id,
            person_id: person.id
          }
          axios.post("/commitment_people", update_people_params).then(function(response){
            console.log(response.data);
          }.bind(this));
          axios.get("/commitments").then(function(response){
            this.commitments = response.data
          }.bind(this));
        }.bind(this));
        

      }.bind(this)).catch(function(error){
        console.log(error);
        this.errors = error.response.data.errors;
        console.log(this.errors);
      }.bind(this));
    },

    // statusCommitments: function(commitment){
    //   if (this.statusFilter == ""){
    //     return true;
    //   } else {
    //     return (commitment.status == this.statusFilter);
    //   }
    // },

    clearFilters: function(){
      this.categoryFilter = "";
      this.statusFilter = "";
    },

    setCategoryFilter: function(attribute){
      if (attribute == this.categoryFilter) {
        this.categoryFilter = "";
      } else {
        this.categoryFilter = attribute;
      }
    },

    setStatusFilter: function(attribute){
      if (attribute == this.statusFilter) {
        this.statusFilter = "";
      } else {
        this.statusFilter = attribute;
      }
    },

    filterCommitments: function(commitment){
      if (this.categoryFilter == "" && this.statusFilter == "") {
        return true;
      } else{
        console.log(this.statusFilter);
        if (this.categoryFilter && this.statusFilter){
          return commitment.category_id == this.categoryFilter && commitment.status == this.statusFilter;
        } 
        else if (this.categoryFilter) {
          this.statusFilter = "";
          return commitment.category_id == this.categoryFilter;  
        } else if (this.statusFilter){
          this.categoryFilter = "";
          return commitment.status == this.statusFilter;
        } 
      } //
    },

    setSortAttribute: function(attribute){
      if(attribute !== this.sortAttribute){
        this.sortAscending = true;
      } else {
        this.sortAscending = !this.sortAscending;
      }

      this.sortAttribute = attribute;
    }
  },
  computed: {
    sortedCommitments: function(){
      return this.commitments.sort(function(commitment1, commitment2){
        if (this.sortAscending && (this.sortAttribute == "what" || this.sortAttribute == "who" || this.sortAttribute == "status")){
          this.sortIcon = "up";
          return commitment1[this.sortAttribute].localeCompare(commitment2[this.sortAttribute]);
        } else if (this.sortAscending == false && (this.sortAttribute == "what" || this.sortAttribute == "who") || this.sortAttribute == "status") {
            this.sortIcon = 'down';
            return commitment2[this.sortAttribute].localeCompare(commitment1[this.sortAttribute]);
          }

        if (this.sortAscending && this.sortAttribute == "due"){
          this.sortIcon = 'up';
          console.log(commitment1.due);
          
          if(commitment1.due > commitment2.due){
            return 1;
          } else if (commitment1.due < commitment2.due) {
            return -1;
          } else {
            return 0;
          }
          
        } else {
          this.sortIcon = "down";
          if(commitment2.due > commitment1.due){
            return 1;
          } else if (commitment2.due < commitment1.due) {
            return -1;
          } else {
            return 0;
          }
        }

        }.bind(this));
      },
      commitmentCount: function(){
        var count = 0;
        this.commitments.forEach(function(commitment){
          if (commitment.status == "Committed"){
            count++;
          }

        }.bind(this));
        console.log("hello");
        var message = "";
        if (count >= 5){
          // message = "Be wary of over committing! "
          this.showWarning = true;
        } else {
          this.showWarning = false;
        }
        return "Current Commitments: " + count;
        
      }
    }
};

var ProfilePage = {
  template: "#profile-page",
  data: function() {
    return {
      message: "Your Profile",
      user: {},
      errors: []
    };
  },
  created: function() {
    axios.get("/profile").then(function(response){
      this.user = response.data;
    }.bind(this));
  },
  methods: {
    deleteUser: function(){
      var id = this.user.id;
      axios.delete("/users/" +id).then(function(response){
        router.push("/");
      }.bind(this)).catch(function(error){
        this.errors = error.response.data.errors;
      }.bind(this));
    },
    updateUser: function(user){
      var params = {
        first_name: this.user.first_name,
        last_name: this.user.last_name,
        user_name: this.user.user_name,
        email: this.user.email,
        bio: this.user.bio,
        profile_picture: this.user.profile_picture
      };
      console.log(params);
      axios.put("/users/" + this.user.id, params).then(function(response){
        console.log(response.data);
      }.bind(this)).catch(function(error){
        this.errors = error.response.data.errors;
      }.bind(this));
    },
    uploadFile: function(event){
      if (event.target.files.length>0) {
        var formData = new FormData();
        formData.append("avatar", event.target.files[0]);
        axios.put("/users/" + this.user.id, formData).then(function(response){
          console.log(response);
          event.target.value = "";
        }.bind(this)).catch(function(error){
          this.errors = error.response.data.errors;
          console.log(this.errors)
        });
      }
    }
  },
  computed: {}
};

var PeopleIndexPage = {
  template: "#people-index-page",
  data: function() {
    return {
      message: "Your People",
      people: [],
      newPerson: {
        first_name: "",
        last_name: "",
        email: "",
        phone: "",
        description: ""
      },
      errors: []
    };
  },
  created: function() {
    axios.get("/people").then(function(response){
      this.people = response.data;
      console.log(response.data);
    }.bind(this));
  },

  methods: {
    addPerson: function(){
      var params = {
        
        first_name: this.newPerson.first_name,
        last_name: this.newPerson.last_name,
        email: this.newPerson.email,
        phone_number: this.newPerson.phone_number,
        description: this.newPerson.description
      };
      axios.post("/people", params).then(function(response){
        console.log(response.data);
        this.people.push(response.data);
        this.newPerson.first_name = "";
        this.newPerson.last_name = "";
        this.newPerson.email = "";
        this.newPerson.phone_number = "";
        this.newPerson.description = "";
      }.bind(this)).catch(function(error){
        this.errors = error.response.data.errors;
      }.bind(this));
    },
  deletePerson: function(person){
      var id = person.id;
      console.log("deleted " + id);
      axios.delete("/people/"+ id).then(function(response){
        var index = this.people.indexOf(person);
        this.people.splice(index,1);
      }.bind(this));
    },
  },
  computed: {}
};

var PersonShowPage = {
  template: "#person-show-page",
  data: function() {
    return {
      person: {},
      errors: []
    };
  },
  created: function() {
    axios.get("/people/" + this.$route.params.id).then(function(response){
      this.person = response.data;
      console.log(this.person);
    }.bind(this));
  },
  methods: {
    personUploadFile: function(event){
      if (event.target.files.length>0) {
        var formData = new FormData();
        formData.append("avatar", event.target.files[0]);
        axios.put("/people/" + this.person.id, formData).then(function(response){
          console.log(response);
          event.target.value = "";
          this.person = response.data;
        }.bind(this)).catch(function(error){
          this.errors = error.response.data.errors;
          console.log(this.errors)
        });
      }
    },
    deletePerson: function(person){
      var id = person.id;
      console.log("deleted " + id);
      axios.delete("/people/"+ id).then(function(response){
        router.push("/people")
      }.bind(this));
    },
    updatePerson: function(person){
      var params = {
        first_name: this.person.first_name,
        last_name: this.person.last_name,
        phone_number: this.person.phone_number,
        email: this.person.email,
        description: this.person.description
      };
      console.log(params);
      axios.put("/people/" + this.person.id, params).then(function(response){
        console.log(response.data);
        console.log("HELLO");
        this.person = person;
      }.bind(this)).catch(function(error){
        console.log(error);
        this.errors = error.response.data.errors;
      }.bind(this));
    },
  },
  computed: {}
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage},
    { path: "/commitments", component: CommitmentsPage},
    { path: "/profile", component: ProfilePage},
    { path: "/people", component: PeopleIndexPage},
    { path: "/people/:id", component: PersonShowPage}

    // { path: "/commitments/:id/edit", component: CommitmentsPage}
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  data: function(){
    return {
      user: {},
      animate: true
    }
  },
  created: function() {
    var jwt = localStorage.getItem("jwt");
    // console.log(jwt);
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  },
  methods: {
    userChange: function(){
      axios.get("/profile").then(function(response){
        this.user = response.data;
        console.log(this.user)
      }.bind(this));
    }
  }

});
