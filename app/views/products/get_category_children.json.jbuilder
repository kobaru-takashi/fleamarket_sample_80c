# json.array! @category_children do |child|
#   json.id child.id
#   json.name child.name
# end

json.array! @grandchildren do |child|
  json.id child.id
  json.name child.name
end