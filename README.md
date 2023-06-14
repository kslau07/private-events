# Rails Project: Private Events

> Link to project specs can be found here:  
> https://www.theodinproject.com/lessons/ruby-on-rails-private-events

> Link to deployed app @ fly.io (app may be offline)  
> https://private-events-app.fly.dev/

## Screenshots

<img src="app/assets/images/screenshot.png" width="300"/>
<img src="app/assets/images/sketch.png" width="300"/>

## Description

We want to build a site similar to a private Eventbrite, which allows users to create events and then manage user signups.

* A user can create events.
* A user can attend many events.
* Events take place at a specific date and a specific location

## My Goals

We've been reading a ton about associations in Rails and I want to apply that knowledge. I hope to gain an understanding of many-to-many relationships along with all of the methods Rails provides for free.

Redoing part of this project now using BEM and SCSS for better organization of CSS.

## Thoughts After

* Following BEM (as best as I could) felt like a big step in the right direction for managing CSS.

* Nesting routes is tricky business and I need to do it several more times to get a feel for it.

* Creating partials helps organization but extracting out too many seems to be a hindrance. Need to find a balance.

* RESTful design requires a shift in thinking about how methods are implemented. Adding methods arbitrarily to a controller or app/helpers feels wrong.