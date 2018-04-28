class Ability
  include CanCan::Ability

  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    
    # set authorizations for different user roles
    if user.role? :admin
      # they get to do it all
      can :manage, :all
      
    elsif user.role? :instructor

      

      # 1. can read currciculums, locations, camps
      can :read, Curriculum
      can :read, Location
      can :read, Camp

      # they can read their own profile
      can :show, User do |u|  
        u.id == user.id
      end

      # 2. can edit their bio and picture, as well as email and phone, but not those
      # of other instructors.
      can :update, User do |u|  
        u.id == user.id
      end

      

      # 4. can read a list of students in their camps and can read student details for
      # any student registered for any of their camps (past or upcoming). They
      # can read associated family information for any student they are
      # authorized to view.

      can :read, Student do |stud|  
        #find the instructor
        intruc = Instructor.map{|i| i if i.user.id == user.id}.first
        display_students = Student.map{|s| }# map to get student who has this instructor
        display_students.include? stud.id
      end

      can :read, Family do |fam|  
        #find the instructor
        intruc = Instructor.map{|i| i if i.user.id == user.id}.first
        display_students = Student.map{|s| }# map to get student who has this instructor
        display_students.include? stud.id
      end

      

      # can :read, Shift do |this_shift|
      #   my_store = user.employee.current_assignment.store_id
      #   shifts = Assignment.current.map{|a| a.shifts.map(&:id) if a.store_id == my_store}.flatten
      #   shifts.include? this_shift.id
      # end
# can :read, Student do |s|  
#         user.student.id == s.id
#       end


    elsif user.role? :parent

      # they can read their own profile
      can :show, User do |u|  
        u.id == user.id
      end

      # 1. can edit their phone, email and password information.
      can :update, User do |u|  
        u.id == user.id
      end

      # 2. can read any information related to camps and curriculums.
      can :read, Curriculum
      can :read, Location #???
      can :read, Camp




      # they can read their own data
      # 3. can manage students associated with their family.
      can :manage, Student do |s|  
        s.family.id == user.id
      end

      # 4. can create new registrations for students in their family,...
      can :create, Registration do |r|  
        r.student.family.id == user.id 
      end

      #4.but may not edit or remove those registrations once payment is made.??????
      can :edit, Registration do |r|  
        r.payment = nil
      end
      # 5. cannot view any information about students and families they are not
      # associated with, save for a list of registrered students on the camp
      # details page.

      
    else
      # read information on camps and curriculums, but do not see lists of
      # people registered for a particular camp, just the number of openings left.
      # 2. can create new family and user accounts.
      can :read, Curriculum
      can :read, Location #???
      can :read, Camp
    end
  end
end
