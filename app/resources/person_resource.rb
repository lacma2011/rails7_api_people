class PersonResource < JSONAPI::Resource
    attributes :name, :email, :username, :password, :city
end
