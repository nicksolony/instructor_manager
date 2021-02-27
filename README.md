# Instructor Manager

This app will provide an access to instructors database and ability to manage it.

## Installation

I've created a seeds.rb file to get some sample data in the app. Run rake db:reset to create databases and  populate data.

## Usage

1. Instructor will have First Name*, Last Name*, Email*, Phone, and Username* and password*
2. Instructor will pick which courses he can teach( Instructor has many courses)
3. Instructor can create new courses and course group, and can delete only courses and course groups that he created
4. Each course belongs to course group
5. Each course has Course length, Course description
6. Instructor has many course groups through courses
7. Course group can't be deleted if it has any courses in it.
    
## Demo
https://youtu.be/tOOs0DBn6HA

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


