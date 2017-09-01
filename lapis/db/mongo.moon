cbson = require("cbson")
config = require("lapis.config").get!
moongoo = require("resty.moongoo")
unless config.mongo
  error "Mongodb configuration is missing"

database_name = config.mongo.database

get_uri = -> config.mongo.host

get_connection = ->
  mg, err = moongoo.new(get_uri!)

  unless mg
    error(err)

  return mg

get_database = () ->
  mg = get_connection!
  db = mg\db(database_name)
  return db

--
--

get_collection = (collection_name) ->
  db = get_database!
  col, err = db\collection(collection_name)
  return col, err

drop_collection = (collection_name) ->
  col = get_collection(collection_name)
  return col\drop!

find_one = (collection_name, query, fields) ->
  col = get_collection(collection_name)
  doc, err = col\find_one query, fields
  return doc, err

map_reduce = (collection_name, map, reduce, flags) ->
  col = get_collection(collection_name)
  doc_or_collection, err = col\map_reduce map, reduce, flags
  return doc_or_collection, err

{
  db: get_database
  :drop_collection
  :find_one
  :get_collection, :map_reduce
}