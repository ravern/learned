User.create! name: "Benjamin Tan", email: "me@benjam.in", role: :teacher, password: "123456"
User.create! name: "John Doe", email: "johndoe@apple.com", role: :student, password: "123456"
User.create! name: "Jasmine Bomb", email: "jas@is.is", role: :student, password: "123456"

Course.create! title: "My first course", description: "My first course is a great course for building web applications...", user: User.find(1)
Modu.create! title: "Generating the project", content: "To generate the project, use a generator.", course: Course.find(1)
Modu.create! title: "Building the first endpoint", content: "Create the route, the controller and the view and add it to memes.", course: Course.find(1)
