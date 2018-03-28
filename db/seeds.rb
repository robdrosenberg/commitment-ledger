Category.create!([
  {title: "Personal"},
  {title: "Work"}
])
User.create!([
  {email: "rob@rob.com", user_name: "robdrosenberg", password_digest: "$2a$10$dqZ8zii4eZZsFjFKNUwdlOzNnhVEPPbw/G5VuSLJmpkLS8Ux4AVYy", first_name: "Robert", last_name: "Rosenberg", bio: "I'm an aspiring web developer. I want to stay committed to my goals and improve as a person!"}
])
Commitment.create!([
  {what: "Finish my capstone project", who: "myself", due: "2018-03-29 21:30:00", status: "Committed", notes: "I'm commiting myself to making this commitment app so that I fullfill my commitment on helping other commit to their commitments :)", user_id: 1, category_id: 2},
  {what: "Call my parents once a week", who: "Mom and Dad", due: nil, status: "Committed", notes: "Keep in better touch with my parents, to make them happy!", user_id: 1, category_id: 1},
  {what: "Work hard at learning web development", who: "myself", due: nil, status: "Complete", notes: "I want to get the most out of my bootcamp experience and want to continually improve throughout the course.", user_id: 1, category_id: 2},
  {what: "Mow the lawn", who: "myself", due: "2018-03-30 12:30:00", status: "Broken", notes: "I don't have a lawn thankfully :)", user_id: 1, category_id: 1},

])

Person.create!([
  {
    first_name: "Myself", last_name: "", email: "robertdr85@gmail.com", description: "For commitments I make to myself", user_id: 1
  },
  {
    first_name: "Michael", last_name: "Scott", email: "mscott@paper.com", description: "I promise you he's cool", brownies: 10, user_id: 1
  },
  {
    first_name: "Nadine", last_name: "Javier", email: "nadine@gmail.com", description: "Awesome maybe", brownies: 10, user_id: 1
  },
  {
    first_name: "Marla", last_name: "Rosenberg", email: "marlajr@hotmail.com", description: "mom", brownies: -20, user_id: 1
  },
  {
    first_name: "Cody", last_name: "Levy", email: "clevy@gmail.com", description: "Lame roommate", brownies: 30, user_id: 1
  }
])

CommitmentPerson.create!([
  {
    commitment_id: 1, person_id: 1
  },
  {
    commitment_id: 2, person_id: 1
  },
  {
    commitment_id: 3, person_id: 1
  },
  {
    commitment_id: 3, person_id: 2
  },
  {
    commitment_id: 1, person_id: 3
  },
  {
    commitment_id: 3, person_id: 3
  },
  {
    commitment_id: 4, person_id: 4
  },
  {
    commitment_id: 4, person_id: 5
  },

])
