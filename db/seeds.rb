User.create! name: "Benjamin Tan", email: "me@benjam.in", role: :teacher, password: "123456"
User.create! name: "John Doe", email: "johndoe@apple.com", role: :student, password: "123456"
User.create! name: "Jasmine Bomb", email: "jas@is.is", role: :student, password: "123456"

Course.create! title: "My first course", description: "My first course is a great course for building web applications...", user: User.find(1)
Modu.create! title: "Generating the project", content: "<script>alert('I\\'m hackerman');</script>", course: Course.find(1)
Comment.create! content: "Boom, this is one hell of a module.", modu: Modu.find(1), user: User.find(2)
Comment.create! content: "Perfect composition and inheritance!", modu: Modu.find(1), user: User.find(3)
Modu.create! title: "Building the first endpoint", content: "Create the route, the controller and the view and add it to memes.", course: Course.find(1)
Comment.create! content: "I like this very much.", modu: Modu.find(2), user: User.find(2)
Comment.create! content: "I'm not really feeling this...", modu: Modu.find(2), user: User.find(3)

Course.create! title: "Secure Coding Practises", description: "Best practises to follow for a secure web app...", user: User.find(1)
Modu.create! title: "Sanitizing input", content: "Santize all user input using the built-in library in the framework.", course: Course.find(2)
Comment.create! content: "Great work teacher!", modu: Modu.find(3), user: User.find(2)
Comment.create! content: "Where can I get more of this?", modu: Modu.find(3), user: User.find(3)
Modu.create! title: "Masking user credentials", content: "All user password must be hashed using SHA256 or similar.", course: Course.find(2)

Course.create! title: "Pentesting Basics", description: "Basic pentesting course for newbies...", user: User.find(1)
Modu.create! title: "SQli", content: "SQLi is very dangerous as it allows modification and leakage of sensitive information in a database.", course: Course.find(3)
Comment.create! content: "Wait a minute, what's going on?", modu: Modu.find(5), user: User.find(2)
Modu.create! title: "XSS", content: "XSS allows for session hijacking and defacement of website.", course: Course.find(3)
Comment.create! content: "I'm completely lost :(", modu: Modu.find(5), user: User.find(3)



