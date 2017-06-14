# *TicketPrice*

**TicketPrice** is a scraper website using the [The SeatGeek API](http://platform.seatgeek.com/).

## User Stories

The following functionality is complete:

- [x] User can view a list of events within 20 miles from San Francisco currently listing in SeatGeek from The SeatGeek Database.
- [x] User can place bid on events
- [x] User can view lowest price and event address in event details by clicking on the title.
- [x] User can search for event.
- [x] User can edit the bid on events.
- [x] User can view all the bids they made on events.
- [x] User sees an error message when the searched event not found.
- [ ] Support background process checking lowest price every x second.
- [ ] Notify user if the lowest price match with their bid.

The following **optional** features are implemented:
- [ ] Show poster images.
- [ ] Customize the UI.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## License

    Copyright [2017] [Chengjiu Hong]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
#
* Ruby version: 2.3.1

* Rails version: 5.1.1

* Database: PostgreSQL 9.6.2

* Configuration: bundle install

* Database creation: rails db:create

* Database initialization: rails db:migrate

* Start the server: rails s

* Go to localhost:3000
