Category.create!([
  {title: "Personal"},
  {title: "Work"}
])
User.create!([
  {email: "test@test.com", user_name: "tester1", password_digest: "$2a$10$dqZ8zii4eZZsFjFKNUwdlOzNnhVEPPbw/G5VuSLJmpkLS8Ux4AVYy", first_name: "Test", last_name: "Account", bio: "This account is for testing this apps functionality!", profile_picture: "https://pbs.twimg.com/profile_images/886372283106721792/zH5tTGlQ.jpg"}
])
Commitment.create!([
  {what: "Finish my capstone project", who: "myself", when: "2018-03-29 21:30:00", status: "Committed", notes: "I'm commiting myself to making this commitment app so that I fullfill my commitment on helping other commit to their commitments :)", user_id: 1, category_id: 2},
  {what: "Call my parents once a week", who: "Mom and Dad", when: nil, status: "Committed", notes: "Keep in better touch with my parents, to make them happy!", user_id: 1, category_id: 1}
])
