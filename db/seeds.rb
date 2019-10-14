if User.where(email: "aathresh@paraginfotech.com").blank?
  User.create!(email: "aathresh@paraginfotech.com", password: "@@Deron5987")
  puts "created Admin user"
end