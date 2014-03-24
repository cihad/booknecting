json.id @book.id
json.name @book.name

json.image do
  json.original root_url.chop + @book.image.url
  json.medium root_url.chop + @book.image.medium.url
end

json.users do
  json.array! @book.users, :id, :username, :view_name
end
