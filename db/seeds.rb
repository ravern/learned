User.create! name: "Benjamin Tan", email: "me@benjam.in", role: :teacher, password: "123456"
User.create! name: "John Doe", email: "johndoe@apple.com", role: :student, password: "123456"
User.create! name: "Jasmine Bomb", email: "jas@is.is", role: :student, password: "123456"

Course.create! title: "My first course", description: "My first course is a great course for building web applications...", user: User.find(1)
Modu.create! title: "Generating the project", content: "To generate the project, use a generator.", course: Course.find(1)
Modu.create! title: "Building the first endpoint", content: "Create the route, the controller and the view and add it to memes.", course: Course.find(1)

Course.Create! title: "Secure Coding Practises", description: "Best practises to follow for a secure web app...", user: User.find(1)
Modu.create! title: "Sanitizing input", content: "Santize all user input using the built-in library in the framework.", course: Course.find(1)
Modu.create! title: "Masking user credentials", content: "All user password must be hashed using SHA256 or similar.", course: Course.find(1)

Course.Create! title: "Pentesting Basics", description: "Basic pentesting course for newbies...", user: User.find(1)
Modu.create! title: "SQli", content: "SQLi is very dangerous as it allows modification and leakage of sensitive information in a database.", course: Course.find(1)
Modu.create! title: "XSS", content: "XSS allows for session hijacking and defacement of website.", course: Course.find(1)



