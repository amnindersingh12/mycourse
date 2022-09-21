# Here is the new task for you. I will share the requirements below.
## Build new app for courses, where user can enroll into multiple courses

1. Courses model with fields `name, language (like ruby, python, js) and course creator (user who added that course)`
2. User model with fields `name, email, role (there can be only two roles: “Admin” and “Member”)` To keep it simple: Roles can be set to user from rails console.
3. User with `role=admin` can do CRUD operations on courses.
4. User with `role=member`, can only see all courses and enroll into that courses
5. On user profile page, it will show user details and courses details in which user has enrolled. Courses details - `course-name, enrollment date, status (status value can be “in-progress”, “completed”)`
6. Application Home page => Courses index page => will show list of all courses and filter selection to filter courses by language.
7. Course show page,
    1. will show button `“Enroll”` if user has not enrolled into it.
    2. If user already enrolled then it will show `“Status: In-Progress” and “Mark as complete” button`.
    3. If user already completed that course then it will show `“Status: Completed”`
    4. count of user who enrolled into that courses
    5. count of user who completed that course
# Note:
* No need to use js or remote true. Add simple HTML request
* Keep UI simple. No need to work on UI or theme or CSS for now. Once whole features are completed, add CSS after that.
* use `devise` gem for user auth.
* from rails console, assign role to users.
