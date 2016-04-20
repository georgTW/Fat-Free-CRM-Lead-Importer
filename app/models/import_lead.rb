require 'csv'

class ImportLead
  def initialize(file)
    @file = file
  end

  def import_assigned_to(assigned)
    @assigned = assigned

    import
  end

  # Sample Format
  # "Source","Title, ""First Name","Last Name", "Email", "Website", "LinkedIn", "Rating", "Company Name","Phone Number", "Mobile Number","Address","City",
  # "ZIP code", "Country", "Referred by", "database name","File Date","id","Production Date"  
def import
    CSV.foreach(@file.path, :converters => :all, :return_headers => false, :headers => :first_row) do |row|
      source, title, first_name, last_name, email, blog, linkedin, rating, company, phone, mobile_phone, street, city, zipcode, country, referred_by, *ende = *row.to_hash.values

      street, city, state, zip, _ = *ende

      lead = Lead.new(:source => source, :title => title, :first_name => first_name, :last_name => last_name,
                      :email => email, :blog => blog, :linkedin => linkedin, :rating => rating, :company => company, :referred_by => referred_by, :phone => phone, :mobile => mobile_phone)

      lead.first_name = "FILL ME" if lead.first_name.blank?
      lead.last_name = "FILL ME" if lead.last_name.blank?
      lead.access = "Private"
      #lead.addressable_id << address

      lead.assignee = @assigned if @assigned.present?

      lead.save!
      address = Address.new(:street1 => street, :city => city, :zipcode => zipcode, :country => country, :addressable_id => lead.id)
      address.save!
    end
  end
end
