Category.create!([
  {title: "Personal"},
  {title: "Work"}
])
Commitment.create!([
  {what: "Finish my capstone project", who: "myself", when: "2018-03-29 21:30:00", status: "Committed", notes: "I'm commiting myself to making this commitment app so that I fullfill my commitment on helping other commit to their commitments :)", user_id: 1, category_id: 2},
  {what: "Call my parents once a week", who: "Mom and Dad", when: nil, status: "Committed", notes: "Keep in better touch with my parents, to make them happy!", user_id: 1, category_id: 1}
])
User.create!([
  {email: "robertdr85@gmail.com", user_name: "robdrosen", password_digest: "$2a$10$xiqba.GSaH4TXc0HQ1xpf.zYaAbVDrWuYLR2Jp.94KDeGh.dyJ3Si", first_name: "Robert", last_name: "Rosenberg", bio: "The creator of the commitment ledger application!", profile_picture: "imgur"}
])
