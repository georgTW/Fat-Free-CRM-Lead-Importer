# FfcrmImportLeads

This project rocks and uses MIT-LICENSE.

## Installation

Fat Free CRM Lead Importer works with Fat Free CRM 0.14.0 onwards. You can add this to your Gemfile:

```ruby
gem 'ffcrm_import_leads', :git => 'https://github.com/georgTW/Fat-Free-CRM-Lead-Importer.git', :branch => "master"
```

If you use the WorldCard Mobile app - use the master branch ````:branch => "master"```` otherwise you can use the not maintained ````generic_csv```` branch.

Run the ````bundle install```` command to install it.

Now featuring direct gdrive import!

This plugin has some hard coded values:
- lead.access = "Public" // Access for all imported leads will be public
- lead.status = "new" // Status will be set to 'New'
- Check for duplicates based on first name, last name and email

## TODO

- Remove hardcoded values
- Error handling

All these values or the order of the import document can be edited in this file: [import_lead.rb](https://github.com/georgTW/Fat-Free-CRM-Lead-Importer/blob/master/app/models/import_lead.rb)

