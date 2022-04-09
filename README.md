Original App Design Project - README Template
===

# Habit Tracker

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
A productivity app that allows users to create custom habits/tasks that they can check off if they have been completed that day/week/month or specific time period.

### App Evaluation
- **Category:** Productivity
- **Mobile:** This app is only supported on mobile (iOS) for now, but we may support other platforms in the future.
- **Story:** Allows users to create custom habits/tasks where they can view whether they have been following their set goals or not.
- **Market:** Any individual, regardless of age/gender/sexuality could choose to use this app.
- **Habit:** This app could be used as often as the time period of the habits/tasks the user sets as goals.
- **Scope:** First we would want our users to create custom habits/tasks with a specific time period on when they plan on completing those habits/tasks (hourly/daily/weekly/monthly/etc). Then they should be checking off those habits/tasks when they are completed.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can sign up and make an account with our app
* User can log in to their account
* User can log out of their account
* User can create custom habits/tasks and set a specific time period for the habit/task to repeat
* User can view what habits/tasks they need to do or have already done on the current day
* User can view a summary of whether they have been keeping up/completing their set habits/tasks on time

**Optional Nice-to-have Stories**

* User must verify their email/phone number first before they can log in
* User can stay logged into their account when they open the app until they log out (maybe "Remember me" option)
* Settings or preferences page for the user
* Light mode and dark mode
* Streak animation (for if you have completed/kept up with your daily habits/tasks) 🔥

### 2. Screen Archetypes

* Login
   * The user will be able to log in with their username and password
* Sign Up
   * The user can sign up for an account with our app using a unique username and password
* Current Day Habits/Tasks List
   * The user will be able to see their habits/tasks for the day including the ones they have already done and the ones they still need to do
* Settings Page
   * The user can store their app preferences here and change the app theme to light mode or dark mode
* Summary Page
   * This page will track how well our user has been keeping up with their habits/tasks and show a data summary with maybe a graph or chart

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Today
* Habits
* Summary
* Settings

**Flow Navigation** (Screen to Screen)

* Log in/Sign up -> Goes to Today page on success
* Today -> View habits/tasks that need to be completed today
* Habits -> Create custom habits/tasks to complete
* Summary -> View data summary or data visualization of user's progress
* Settings -> Toggle and save settings

## Wireframes
<img src="https://user-images.githubusercontent.com/67300899/160302620-28a07b51-d7b7-4890-82cd-3a687c57f565.jpeg" height=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema
### Models
#### User
| Property  | Type     | Description |
| ----------| -------- | ------------|
| userId    | Int      | Unique user ID (primary key) |
| createdAt | DateTime | Date and time of when the user account was created |
| username  | String   | User's account name |
| password  | String   | User's account password |
#### Habit
| Property         | Type     | Description |
| -----------------| -------- | ------------|
| habitId          | Int      | Unique user ID (primary key) |
| createdAt        | DateTime | Date and time of when the habit was created |
| habitDescription | String   | Description of the habit |
| habitRepeat      | Int      | How often the habit should be repeated in seconds |
| habitIsDone      | Boolean  | If the habit has been completed for the day/week/month/etc. |
### Networking
   - Login Page
     ```swift
     let username = usernameField.text!
     let password = passwordField.text!
        
     PFUser.logInWithUsername(inBackground: username,
                              password: password) { (user, error) in
        if user != nil {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
        else {
            print("Error: \(String(describing: error?.localizedDescription))")
        }
     }
     ```
   - Sign Up Page
     ```swift
     // Create a user and get their username and password
     let user = PFUser()
     user.username = usernameField.text
     user.password = passwordField.text
        
     // If sign up is a success, we can login
     user.signUpInBackground { (success, error) in
         if success {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
         }
         else {
            print("Error: \(String(describing: error?.localizedDescription))")
         }
     }
     ```
   - Tasks List Page
      - (Read/GET) Query all the habits for today and planned habits for other days
         ```swift
         let query = PFQuery(className:"Habit")
         query.whereKey("user", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (habits: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            }
            else if let habits = habits {
               print("Successfully retrieved \(habits.count) habits.")
               // TODO: Do something with habits...
            }
         }
         ```
      - (Create/POST) Create a new habit
        ```swift
        // Create the habit
        let habit = PFObject(className: "Habit")
        habit["description"] = text
        habit["repeat"] = repeat
        habit["isDone"] = isDone

        habit.add(habit, forKey: "habits")
        habit.saveInBackground { (success, error) in
           if success {
               print("Habit created!")
           }
           else {
               print("Error creating habit!")
           }
        }
        tableView.reloadData()
        ```
      - (Delete) Delete an existing habit
   - Summary Page
      - (Read/GET) Number of habits done throughout a time period week/month/year/etc.
   - Settings Page
      - (Read/GET) Gets the user preferred settings
#### [OPTIONAL:] Existing API Endpoints
