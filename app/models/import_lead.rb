require 'csv'

class ImportLead
  def initialize(file)
    @file = file
  end

  def import_assigned_to(assigned)
    @assigned = assigned

    import
  end

  # Sample Format for WorldCard Mobile (https://itunes.apple.com/en/app/worldcard-mobile-business/id333211045?mt=8) 
  # Export as CSV File Outlook format
def import
    total = 0
    c = 0
    CSV.foreach(@file.path, :converters => :all, :return_headers => false, :headers => :first_row) do |row|
      first_name = row['First Name']
      last_name = row['Last Name']
      company = row['Company']
      title = row['Job Title']
      street = row['Business Street']
      city = row['Business City']
      state = row['Business State']
      zipcode = row['Business Postal Code']
      country = row['Business Country/Region']
      phone = row['Business Phone']
      mobile_phone = row['Mobile Phone']
      email = row['E-mail Address']
      alt_email = row['E-mail 2 Address']
      blog = row['Web Page']
      notes = row['Notes']
      *leftover = *row.to_hash.values
      
      # leftover array contains all remaining columns of the document, if you need additional values inserted, just address them like shown below 
      value1, value2, _ = *leftover

      # Check for duplicates based on first_name, last_name and email
      total += 1
      if Lead.where(first_name: first_name, last_name: last_name, email: email).present?
        c += 1
	      next # Skip item if duplicate
      end

      lead = Lead.new(:title => title, :first_name => first_name, :last_name => last_name,
                      :email => email, :blog => blog, :alt_email => alt_email, :company => company, :phone => phone, :mobile => mobile_phone)

      # Add Lead
      lead.first_name = "FILL ME" if lead.first_name.blank?
      lead.last_name = "FILL ME" if lead.last_name.blank?
      lead.access = "Public"
      lead.status = "new"
      lead.assignee = @assigned if @assigned.present?
      lead.save!

      # Add Business address to Lead
      address = Address.new(:street1 => street, :city => city, :zipcode => zipcode, :country => country, :addressable_id => lead.id)
      address.addressable_type = 'Lead'
      address.address_type = 'Business'
      address.save!

      # Add Comments to Lead
      if notes
        notes = Comment.new(:comment => notes, :user_id => lead.assigned_to, :commentable_id => lead.id)
        notes.commentable_type = 'Lead'
        notes.save!
      end
      
    end
    [total,c]
  end
end
