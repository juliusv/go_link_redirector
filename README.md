# Go Link Redirector

## Overview

This is a simple short-link URL redirector written in [Rails][0] for use within
organizations that use [Google Apps][1]. It requires users to sign in via their
organization's Google Apps account before using, editing, or creating any
links. However, once logged in, any user has full rights to access and change
any link.

## Features

  * domain-based user authentication via Google Apps
  * creating, updating and viewing details of short links
  * searchable overview of all links in system
  * tracking of link owners and of the last person to change a link

## Installation

### Creating Your Google Apps Client Application Credentials.

Visit https://code.google.com/apis/console/

  * click on "Create Project" (if you don't have a project yet)
  * select on "API Access" from the left menu
  * select "Create an OAuth 2.0 client ID..."
    * Product name: a name of your choosing
    * Product logo: your logo here (or leave empty)
    * Application type: "Web application"
    * Your site or hostname: root URL where you will run the link redirector
    * click "Create client ID"
  * select "Edit settings..." on your new application
  * under "Authorized Redirect URIs", add
    "http://yourdomain.com/auth/google_oauth2/callback", replacing the first
    part with the URL where the redirector will run
  * the dashboard will now list a "Client ID" and "Client secret" for your
    application, which you will need to configure in the `google_oauth2` section
    in your application's config.yml below

### Downloading, Configuring and Running

```bash
# Download the redirector.
git clone https://github.com/juliusv/go_link_redirector.git
cd go_link_redirector

# Edit the application configuration and supply your Google Apps API credentials.
vim config/config.yml

# Edit the database configuration.
vim config/database.yml

# Change the secret cookie-signing token (random >30 characters string).
vim config/initializers/secret_token.rb

# Install dependencies.
bundle install

# Initialize the database.
rake db:migrate

# (optional, for demo purposes) Populate the database with test links.
# rake db:populate

# Start the application.
rails server
```

For further details on configuring and running [Rails][0] applications, see the
[Rails Documentation][2] page or read the `RAILS_README.rdoc` file.

## Tests

```bash
# Prepare test database.
rake db:test:prepare

# Run tests.
rake spec
```

## Authors

Julius Volz (julius.volz@gmail.com)

## Contributing

Pull requests welcome!

[0]: http://rubyonrails.org/
[1]: http://www.google.com/enterprise/apps/business
[2]: http://rubyonrails.org/documentation
