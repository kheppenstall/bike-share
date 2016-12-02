[![Stories in Ready](https://badge.waffle.io/kheppenstall/bike-share.png?label=ready&title=Ready)](https://waffle.io/kheppenstall/bike-share)
[![Stories in Ready](https://badge.waffle.io/kheppenstall/bike-share.svg?label=ready&title=Ready)](http://waffle.io/kheppenstall/bike-share)

# Bike Share

## Abstract

In this project you'll use Ruby, Sinatra, and Activerecord to build a site that analyzes bike share usage in San Francisco.

This application will collect data in two ways: 1) through web forms allowing users to enter trip/station/weather information, and 2) by consuming CSV files with historical information for stations, trips, and weather. In addition to creating and storing this information for viewing at a later date, this application will provide a number of user dashboards with higher level analysis of trends in bike share usage.

At a high level, this project will develop along the following path:

* Iteration 1: Allow users to save and view information related to bike share stations.
* Iteration 2: Create a seed file to consume information on the seventy existing bike share stations in San Francisco.
* Iteration 3: Create a station dashboard with analysis of station information (split by city, date installed, number of of bicycle docks)
* Iteration 4: Allow users to save and view information related to trips taken.
* Iteration 5: Update the seed file to consume information on the nearly 670,000 trips taken between August 29, 2013, and August 81, 2015.
* Iteration 6: Add information to the station dashboard using trip information, and create a trip dashboard with an analysis of trips taken.
* Iteration 7: Allow users to enter weather information.
* Iteration 8: Update the seed file to consume weather information.
* Iteration 9: Create a weather dashboard and update the trip dashboard with additional analytics regarding the relationship between weather and trips taken.

## Learning Goals

### ActiveRecord

* Use ActiveRecord migrations to create a normalized database
* Use intermediate ActiveRecord queries to calculate and report on information in the database
* Utilize ActiveRecord methods and relationships to efficiently query the database

### User Experience and Conventions

* Use Sinatra and ERB templates to render views to create, read, update, and delete resources using restful routes and appropriate HTTP verbs
* Use Sinatra and ERB templates to display a dashboard not related to a specific resource saved in the database
* Use HTML and CSS to create a user experience that allows users to comfortably navigate a site

### Code Organization/Quality

* Organize code using best practices (use POROs when appropriate, avoid long methods, etc.)
* Create methods using ActiveRecord on the appropriate class.

### Testing

* Use RSpec to drive development at the feature and model levels.

### Working Collaboratively

* (unevaluated) Use Git and GitHub to work collaboratively, develop in smaller groups, and resolve merge conflicts

## Getting Started

### Define the Relationship with Your Group

DTR with youg group [here](https://gist.github.com/case-eee/38e212c799c563f58766128b5057858a). One group member should send a link of the forked gist to your anchor as soon as it's complete.

### Clone the Project

1. One team member forks this skeleton repository.
1. Add the other team members as collaborators.
1. Add instructors as collaborators.

### Requirements

This project must use:

* [Sinatra](http://www.sinatrarb.com/)
* [PostgreSQL](http://www.postgresql.org/) (this is configured for you)
* [ActiveRecord](http://guides.rubyonrails.org/active_record_basics.html)

You'll want to set up the [DatabaseCleaner](https://github.com/DatabaseCleaner/database_cleaner) gem in order to have a clean database each time you run tests. Follow the instructions for setting up the gem. Due to a bug in the most recent version of the gem, you'll need to use this line when you set the strategy in your test helper file:

```ruby
  DatabaseCleaner.strategy = :truncation
```

See the "Resources" section at the bottom of this page for additional helpful documentation.

Before starting, make sure you have the [Postgres App](http://postgresapp.com/) installed.

### Restrictions

The project may not use:

* `Rails`

## Instructions

Iterations 0-9 must be completed in order to consider the project complete. Please use TDD throughout. Tests are expected for all features and all models.

## Base Expectations

### Iteration 1

Create full CRUD functionality for a station with the following characteristics:

* name
* dock count
* city
* installation date

Once you have the `Station` model started, finish it off by creating validations for the `Station` attributes.

* All the attributes must be present.

You can use ActiveRecord's [validations feature](http://guides.rubyonrails.org/active_record_validations.html) to make sure no record is saved without having all attributes present.

**Be sure to have a test for each individual validation.**

Also, be sure to normalize the table(s) that you build to hold this information, and to use restful routes. What's normalization you ask? Check out the homework assignments for Day 4 [here](https://github.com/turingschool/homework/blob/master/module-2-homework.markdown) and this [overview](https://gist.github.com/Carmer/f9e060bf1ac30e3ab7b3). 

**Hint:** Any data that will be repeated in a significant amount of rows in your `stations` table should probably be extracted to its own table.

At the end of this iteration, you should be able to view an index of all stations, view a page for a single station, create a station, edit a station, and delete a station from either the index or the show pages.

### Iteration 2

Download the dataset available [here](https://www.kaggle.com/benhamner/sf-bay-area-bike-share). This will include all of the CSV files that you will be using in this project. Since these files are large, we have set up your project directory structure and `.gitignore` so that when you add these files to the `/db/csv/` directory they will not be pushed up to GitHub. However, this also means that each of the members of your team will need to download these files independently.

Update the seed file in your `/db` directory and add the `station.csv` file to your `/db/csv/` directory. When you run `ruby db/seed.rb` your development database should be populated with the information from the `station.csv` file. Your index should include a total of seventy stations.

### Iteration 3

Create a station dashboard route. When you visit `/station-dashboard` you should be shown a page with the following information:

* Total count of stations
* Average bikes available per station (based on docks).
* Most bikes available at a station.
* Station(s) where the most bikes are available.
* Fewest bikes available at a station.
* Station(s) where the fewest bikes are available.
* Most recently installed station.
* Oldest station.

### Iteration 4

Create full CRUD functionality for a trip with the following characteristics:

* Duration
* Start Date
* Start Station
* End Date
* End Station
* Bike ID
* Subscription Type
* Zip Code

As with `Station`'s, all attributes of a `Trip` need to be present to ensure data integrity. Don't forget your validations and tests for each validation.

As with Iteration 1, be sure that you are working to normalize your database. This may mean using references to existing tables. At the end of this iteration users should be able to visit the following routes:

* `/trips`
* `/trips/:id`
* `/trips/new`
* `/trips/:id/edit`

When a user visits the `/trips` path, they should only see the first thirty trips taken organized by date. On that page, there should also be a button to see the next thirty trips. Once a user visits a second page, there should be buttons to move both forward and backward in time.

Additionally, users should be able to delete a trip from the views rendered at both `/trips/:id` and `/trips`.


### Iteration 5

Add the `trip.csv` file to your `db/csv` directory, and update your `seed.rb` file so that it also imports the information in `trip.csv`. Be sure to adjust your seed file so that when it is run it does not create duplicate data.

### Iteration 6

Create a trips dashbord route. When you visit `/trips-dashboard` users should be shown a page with the following information:

* Average duration of a ride.
* Longest ride.
* Shortest ride.
* Station with the most rides as a starting place.
* Station with the most rides as an ending place.
* Month by Month breakdown of number of rides with subtotals for each year.
* Most ridden bike with total number of rides for that bike.
* Least ridden bike with total number of rides for that bike.
* User subscription type breakout with both count and percentage.
* Single date with the highest number of trips with a count of those trips.
* Single date with the lowest number of trips with a count of those trips.

On the station dashboard add the following information:

* Number of rides started at this station.
* Number of rides ended at this station.
* Most frequent destination station (for rides that began at this station).
* Most freuqnet origination station (for rides that ended at this station).
* Date with the highest number of trips started at this station.
* Most frequent zip code for users starting trips at this station.
* Bike ID most frequently starting a trip at this station.

### Iteration 7

Create full CRUD functionality for a day's weather conditions with the following characteristics:

* Date
* Max Temperature
* Mean Temperature
* Min Temperature
* Mean Humidity
* Mean Visibility (in Miles)
* Max Wind Speed (mph)
* Precipitation (inches)

At the end of this iteration users should be able to visit the following routes:

* `/conditions`
* `/conditions/:id`
* `/conditions/new`
* `/conditions/:id/edit`

As with `/trips`, users should only be shown the weather conditions for thirty days when they visit `/conditions` and should be able to navigate to other pages with forward/backward buttons.

Additionally, users should be able to delete a the weather conditions for a particular date from the views rendered at both `/conditions/:id` and `/conditions`.

### Iteration 8

Add the `weather.csv` file to your `db/csv` directory, and update your `seed.rb` file so that it also imports the information in `weather.csv`. Be sure to adjust your seed file so that when it is run it does not create duplicate data.

### Iteration 9

Create a weather dashboard available at `/weather-dashboard` that includes the following information:

* Breakout of average number of rides, highest number of rides, and lowest number of rides on days with a high temperature in 10 degree chunks (e.g. average number of rides on days with high temps between fifty and sixty degrees)
* Breakout of average number of rides, highest number of rides, and lowest number of rides on days with precipitation in half-inch increments.
* Breakout of average number of rides, highest number of rides, and lowest number of rides on days with mean wind speeds in four mile increments.
* Breakout of average number of rides, highest number of rides, and lowest number of rides on days with mean visibility in miles in four mile increments.

Add the following information to your trip dashboard:

* Weather on the day with the highest rides.
* Weather on the day with the lowest rides.

## Extensions

* Use [Google Charts](https://developers.google.com/chart/) to display information on one or more of your dashboards.
* Read about [JSON](http://www.ruby-doc.org/stdlib-2.0/libdoc/json/rdoc/JSON.html). Create an endpoint at `api/v1/stations/:id` that responds to requests with JSON instead of HTML.
* Deploy your application to [Heroku](https://devcenter.heroku.com/articles/rack)
* Import minute by minute data for stations and use that data to create additional analytics.
* Add latitude and longitude to your station table. Create a Google map with pins for each of the stations.

## Evaluation Rubric

The project will be assessed with the following rubric:

### 1. Functional Expectations

* 4: Application fulfills base expectations and adds two extensions
* 3: Application fulfills base expectations
* 2: Application has some small missing base functionality
* 1: Application is not usable

### 2. ActiveRecord

* 4: Appropriate ActiveRecord methods are used to query the database and live in the appropriate model. No Ruby is used to organize data after database queries.
* 3: ActiveRecord methods generally live in the appropriate model, but some Ruby is used to organize data after database queries. A project at this level may have some queries that have not produced the correct results based on the expectations described, but in those cases the query was still generally on the right path and demonstrated some minor misunderstanding.
* 2: Limited use of ActiveRecord methods (for exxample: frequent use of `.all` followed by data manipulation using Ruby where other ActiveRecord methods would be more appropriate). Projects at this level may also include queries that do not produce correct results, but the query would likely need to be completely rewritten.
* 1: Applciation shows little understanding of ActiveRecord and likely fails to query the database to obtain the information necessary to meet project requirements.

### 3. User Experience and Conventions

* 4: Project uses Sinatra methods and ERB templates to display both resources and non-resource related views with appropriate routes, and HTTP verbs. All functionality can be accessed in the application where expected based on the spec. User experience is exceptional ('client ready') and all pieces of the application can be accessed without entering addresses manually in the nav bar.
* 3: Project still uses appropriate routes and HTTP verbs. User experience is pleasant, but may need additional improvement before truly being ready to be deployed to production for a client.
* 2: Appication is difficult to navigate, and may not follow restful conventions. This project may have limited styling.
* 1: Application does not follow conve

### 4. Code Organization/Quality

* 4: Code is organized so that the main application file is primarily concerned with HTTP requests/responses. Other logic is refactored to be included in other Ruby objects, and code responsible for analyzing information in the database exists in the appropriate ActiveRecord models. Methods are appropriately refactored to have a specific purpose and generally do not exceed eight to ten lines. The purpose of methods is generally clear and easy to understand/follow. Logic is not included in ERB views, and is instead in the controller or model as appropriate.
* 3: Some logic not related specifically to HTTP requests/resesponses remains in the main application file. Some methods may be slightly long, or follow unexpected patterns. Limited logic may leak into the views.
* 2: Code does not represent a significant effort to refactor. Logic leaks into the views or controllers. Long methods may exist, and the purpose behind some methods may be unclear.
* 1: Code is disorganized and will likely be difficult to understand/maintain.

### 5. Testing

* 4: Application is broken into components which are well tested in both isolation and integration using appropriate data
* 3: Application is well tested but does not balance isolation and integration/feature tests
* 2: Application makes some use of tests, but the coverage is insufficient
* 1: Application does not demonstrate strong use of TDD

### 6. Working Collaboratively

* 4: Excellent use of branches, pull requests, and a project management tool.
* 3: Good use of branches, pull requests, and a project-management tool.
* 2: Sporadic use of branches, pull requests, and/or project-management tool.
* 1: Little use of branches, pull requests, and/or a project-management tool.
