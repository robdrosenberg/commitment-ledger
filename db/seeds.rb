# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
  {
    email: "robertdr85@gmail.com", 
    user_name: "robdrosen", 
    first_name: "Robert", 
    last_name: "Rosenberg", 
    password: "nil", 
    bio: "The creator of the commitment ledger application!", 
    profile_picture: "imgur"
  }
)

Commitment.create(
  {
    what: "Finish my capstone project",
    who: "myself",
    when: "2018-03-29 21:30:00",
    status: "Committed",
    notes: "I'm commiting myself to making this commitment app so that I fullfill my commitment on helping other commit to their commitments :)"
  }
)