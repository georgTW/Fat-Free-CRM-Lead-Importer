# FfcrmImportLeads

This project rocks and uses MIT-LICENSE.

## Installation

Fat Free CRM Lead Importer works with Fat Free CRM 0.14.0 onwards. You can add it to your Gemfile

```ruby
gem 'ffcrm_import_leads', :git => 'https://github.com/georgTW/Fat-Free-CRM-Lead-Importer.git'
```

Run the ````bundle install```` command to install it.


This plugin has some hard coded values:
- lead.access = "Public" // Access for all imported leads will be public
- lead.status = "new" // Status will be set to 'New'

To import you should use the following structure for your .csv file:
````
"Source", "Title, "First Name", "Last Name", "Email", "Website", "LinkedIn", "Rating", "Company Name", "Phone Number", "Mobile Number", "Address", "City", "ZIP code", "Country", "Referred by"
````

For mapping the country the official ISO alpha-2 code is used: https://www.iso.org/obp/ui/#search

All these values or the order of the import document can be edited in this file: https://github.com/georgTW/Fat-Free-CRM-Lead-Importer/blob/master/app/models/import_lead.rb

